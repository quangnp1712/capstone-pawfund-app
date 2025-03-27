// ignore_for_file: empty_catches

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/features/data/models/account_model.dart';
import 'package:capstone_pawfund_app/features/data/models/account_verification_model.dart';
import 'package:capstone_pawfund_app/features/domain/repository/auth_repo/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  SendVerificationModel? _sendVerificationModel;
  AccountModel? _accountModel;

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationInitialEvent>(_authenticationInitialEvent);
    on<AuthenticationShowRegisterEvent>(_authenticationShowRegisterEvent);
    on<RegisterSelectGenderEvent>(_registerSelectGenderEvent);
    on<SendVerificationAccountEvent>(_sendVerificationAccountEvent);
    on<VerificationAccountCodeEvent>(_verificationAccountCodeEvent);
    on<AuthenticationRegisterEvent>(_authenticationRegisterEvent);
  }

  FutureOr<void> _authenticationInitialEvent(
      AuthenticationInitialEvent event, Emitter<AuthenticationState> emit) {
    emit(ShowLoginPageState());
  }

  FutureOr<void> _authenticationShowRegisterEvent(
      AuthenticationShowRegisterEvent event,
      Emitter<AuthenticationState> emit) {
    emit(ShowRegisterPageState());
  }

  FutureOr<void> _registerSelectGenderEvent(RegisterSelectGenderEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    emit(ShowRegisterPageState(gender: event.gender));
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
        emit(VerificationAccountState());
      } else {
        emit(VerificationAccountState());

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
              email: event.accountModel.email,
              verificationCode: event.verificationCode);
      _accountModel = event.accountModel;
      var results = await AuthenticationRepository()
          .verificationAccountCode(accountVerificationCodeModel);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseBody = results['body'];
      AccountVerifyResponse accountVerifyResponse;
      if (responseStatus) {
        accountVerifyResponse = AccountVerifyResponse.fromJson(responseBody);

        // event dang ky
        add(AuthenticationRegisterEvent(accountModel: event.accountModel));
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
        emit(ShowLoginPageState());
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, status: responseStatus));
      }
    } catch (e) {}
  }
}
