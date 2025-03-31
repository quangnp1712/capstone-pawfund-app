// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/features/data/models/account_model.dart';
import 'package:capstone_pawfund_app/features/data/models/account_verification_model.dart';
import 'package:capstone_pawfund_app/features/data/models/session_model.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';
import 'package:capstone_pawfund_app/features/domain/repository/auth_repo/auth_repo.dart';
import 'package:capstone_pawfund_app/features/presentation/home_page/home_page.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  SendVerificationModel? _sendVerificationModel;
  AccountModel? _accountModel;
  String _routeFrom = "";

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationInitialEvent>(_authenticationInitialEvent);
    on<AuthenticationShowRegisterEvent>(_authenticationShowRegisterEvent);
    on<SendVerificationAccountEvent>(_sendVerificationAccountEvent);
    on<VerificationAccountCodeEvent>(_verificationAccountCodeEvent);
    on<AuthenticationRegisterEvent>(_authenticationRegisterEvent);
    on<AuthenticationLoginEvent>(_authenticationLoginEvent);
  }

  FutureOr<void> _authenticationInitialEvent(
      AuthenticationInitialEvent event, Emitter<AuthenticationState> emit) {
    try {
      if (event.routeTo == "LOGIN") {
        emit(ShowLoginPageState());
      }
      if (event.routeFrom != "") {
        _routeFrom = event.routeFrom;
      }
      emit(ShowLoginPageState());
    } catch (e) {}
  }

  FutureOr<void> _authenticationShowRegisterEvent(
      AuthenticationShowRegisterEvent event,
      Emitter<AuthenticationState> emit) {
    emit(ShowRegisterPageState());
  }

  FutureOr<void> _sendVerificationAccountEvent(
      SendVerificationAccountEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    try {
      var results =
          await AuthenticationRepository().verificationAccount(event.email);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseBody = results['body'];
      SendVerificationResponse sendVerificationResponse;

      if (responseStatus) {
        sendVerificationResponse =
            SendVerificationResponse.fromJson(responseBody);
        _sendVerificationModel = sendVerificationResponse.data;
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, status: responseStatus));
      }
    } catch (e) {}
  }

  FutureOr<void> _verificationAccountCodeEvent(
      VerificationAccountCodeEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    try {
      AccountVerificationCodeModel accountVerificationCodeModel =
          AccountVerificationCodeModel(
              email: event.email, verificationCode: event.verificationCode);
      var results = await AuthenticationRepository()
          .verificationAccountCode(accountVerificationCodeModel);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseBody = results['body'];
      AccountVerifyResponse accountVerifyResponse;
      if (responseStatus) {
        accountVerifyResponse = AccountVerifyResponse.fromJson(responseBody);
        if (event.route == "REGISTER") {
          emit(ShowLoginPageState());
          emit(ShowSnackBarActionState(
              message: "Kích hoạt tài khoản thành công",
              status: responseStatus));
        }
      } else if (responseBody['status'] == "404") {
        emit(ShowSnackBarActionState(
            message: "Mã xác thực không đúng", status: responseStatus));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, status: responseStatus));
      }
    } catch (e) {}
  }

  FutureOr<void> _authenticationRegisterEvent(AuthenticationRegisterEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    try {
      var results =
          await AuthenticationRepository().register(event.accountModel);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseBody = results['body'];
      if (responseStatus) {
        emit(ShowSnackBarActionState(
            message: "Đăng ký thành công", status: responseStatus));
        add(SendVerificationAccountEvent(email: event.accountModel.email!));
        emit(ShowVerificationEmailState(email: event.accountModel.email!));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, status: responseStatus));
      }
    } catch (e) {}
  }

  FutureOr<void> _authenticationLoginEvent(
      AuthenticationLoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    try {
      AccountModel accountLogin =
          AccountModel(email: event.email, password: event.password);
      var results = await AuthenticationRepository().login(accountLogin);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseBody = results['body'];
      if (responseStatus) {
        SessionResponse sessionResponse =
            SessionResponse.fromJson(responseBody);
        // save info acc
        AuthPref.setToken(sessionResponse.data!.accessToken.toString());
        AuthPref.setName(
            "${sessionResponse.data!.account!.firstName.toString()} ${sessionResponse.data!.account!.lastName.toString()}");
        // AuthPref.setRole(role);
        AuthPref.setCusId(sessionResponse.data!.account!.accountId as int);

        emit(ShowSnackBarActionState(
            message: "Đăng nhập thành công", status: responseStatus));
        if (_routeFrom == "HOME") {
          Get.toNamed(HomePage.HomePageRoute);
        }
        Get.back();
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, status: responseStatus));
      }
    } catch (e) {}
  }
}
