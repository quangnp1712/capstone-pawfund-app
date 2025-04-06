// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/core/utils/check_asset_image.dart';
import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/features/data/models/account_model.dart';
import 'package:capstone_pawfund_app/features/data/models/account_verification_model.dart';
import 'package:capstone_pawfund_app/features/data/models/session_model.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';
import 'package:capstone_pawfund_app/features/domain/repository/auth_repo/auth_repo.dart';
import 'package:capstone_pawfund_app/features/presentation/home_page/home_page.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  SendVerificationModel? _sendVerificationModel;
  AccountModel? _accountModel;

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationInitialEvent>(_authenticationInitialEvent);
    on<AuthenticationShowRegisterEvent>(_authenticationShowRegisterEvent);
    on<AuthenticationShowLoginEvent>(_authenticationShowLoginEvent);
    on<SendVerificationAccountEvent>(_sendVerificationAccountEvent);
    on<VerificationAccountCodeEvent>(_verificationAccountCodeEvent);
    on<AuthenticationRegisterEvent>(_authenticationRegisterEvent);
    on<AuthenticationLoginEvent>(_authenticationLoginEvent);
  }

  FutureOr<void> _authenticationInitialEvent(
      AuthenticationInitialEvent event, Emitter<AuthenticationState> emit) {
    try {
      emit(ShowLoginPageState());
    } catch (e) {}
  }

  FutureOr<void> _authenticationShowRegisterEvent(
      AuthenticationShowRegisterEvent event,
      Emitter<AuthenticationState> emit) {
    emit(ShowRegisterPageState());
  }

  FutureOr<void> _authenticationShowLoginEvent(
      AuthenticationShowLoginEvent event, Emitter<AuthenticationState> emit) {
    emit(ShowLoginPageState());
  }

  FutureOr<void> _sendVerificationAccountEvent(
      SendVerificationAccountEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationChangeState());
    emit(AuthenticationLoadingState(isLoading: true));
    emit(AuthenticationChangeState());

    try {
      var results =
          await AuthenticationRepository().sendVerificationAccount(event.email);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      SendVerificationResponse sendVerificationResponse;
      emit(AuthenticationLoadingState(isLoading: false));

      if (responseSuccess) {
        sendVerificationResponse =
            SendVerificationResponse.fromJson(responseBody);
        _sendVerificationModel = sendVerificationResponse.data;
        emit(ShowSnackBarActionState(
            message: "Gửi mã xác thực thành công. Bạn hãy kiểm tra email!",
            success: responseSuccess));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      emit(AuthenticationLoadingState(isLoading: false));
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _verificationAccountCodeEvent(
      VerificationAccountCodeEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationChangeState());
    emit(AuthenticationLoadingState(isLoading: true));
    emit(AuthenticationChangeState());

    try {
      AccountVerificationCodeModel accountVerificationCodeModel =
          AccountVerificationCodeModel(
              email: event.email, verificationCode: event.verificationCode);
      var results = await AuthenticationRepository()
          .verificationAccountCode(accountVerificationCodeModel);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      AccountResponse accountVerifyResponse;

      emit(AuthenticationLoadingState(isLoading: false));
      if (responseSuccess) {
        accountVerifyResponse = AccountResponse.fromJson(responseBody);
        if (event.route == "REGISTER") {
          emit(ShowLoginPageState(email: event.email));
          emit(ShowSnackBarActionState(
              message: "Kích hoạt tài khoản thành công",
              success: responseSuccess));
        }
      } else if (responseStatus != null && responseStatus == 404) {
        emit(ShowSnackBarActionState(
            message: "Mã xác thực không đúng", success: responseSuccess));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      emit(AuthenticationLoadingState(isLoading: false));
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _authenticationRegisterEvent(AuthenticationRegisterEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationChangeState());

    emit(AuthenticationLoadingState(isLoading: true));
    emit(AuthenticationChangeState());
    try {
      var results =
          await AuthenticationRepository().register(event.accountModel);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      emit(AuthenticationLoadingState(isLoading: false));

      if (responseSuccess) {
        emit(ShowSnackBarActionState(
            message: "Đăng ký thành công", success: responseSuccess));
        add(SendVerificationAccountEvent(email: event.accountModel.email!));
        emit(ShowVerificationEmailState(email: event.accountModel.email!));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      emit(AuthenticationLoadingState(isLoading: false));
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _authenticationLoginEvent(
      AuthenticationLoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationChangeState());

    emit(AuthenticationLoadingState(isLoading: true));
    emit(AuthenticationChangeState());
    try {
      final storage = FirebaseStorage.instance;

      AccountModel accountLogin =
          AccountModel(email: event.email, password: event.password);
      var results = await AuthenticationRepository().login(accountLogin);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      if (responseSuccess) {
        SessionResponse sessionResponse =
            SessionResponse.fromJson(responseBody);
        // save info acc
        // AuthPref.setRole(role);
        if (sessionResponse.data?.account != null) {
          AuthPref.setToken(sessionResponse.data!.accessToken.toString());
          AuthPref.setName(
              "${sessionResponse.data?.account!.firstName.toString()} ${sessionResponse.data!.account!.lastName.toString()}");
          AuthPref.setCusId(sessionResponse.data?.account!.accountId as int);
          AuthPref.setPhone(sessionResponse.data!.account!.phone.toString());
          AuthPref.setEmail(sessionResponse.data!.account!.email.toString());
          AuthPref.setPassword(event.password.toString());
          if (sessionResponse.data!.account!.medias != null) {
            for (var _media in sessionResponse.data!.account!.medias!) {
              if (_media.isThumbnail!) {
                try {
                  var reference = storage.ref(_media.url);
                  var avatarUrl = await reference.getDownloadURL();
                  AuthPref.setAvatar(avatarUrl.toString());
                  break;
                } catch (e) {
                  DebugLogger.printLog(e.toString());
                }
              }
            }
          }
        }
        emit(AuthenticationLoadingState(isLoading: false));

        emit(ShowSnackBarActionState(
            message: "Đăng nhập thành công", success: responseSuccess));

        Get.back(result: true);
      } else if (responseStatus == 404) {
        emit(AuthenticationLoadingState(isLoading: false));

        emit(ShowSnackBarActionState(
            message: "Email hoặc mật khẩu không đúng",
            success: responseSuccess));
      } else if (responseStatus == 401) {
        emit(AuthenticationLoadingState(isLoading: false));
        add(SendVerificationAccountEvent(email: event.email));
        emit(ShowVerificationEmailState(email: event.email));

        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      } else {
        emit(AuthenticationLoadingState(isLoading: false));

        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      emit(AuthenticationLoadingState(isLoading: false));
      DebugLogger.printLog(e.toString());
    }
  }
}
