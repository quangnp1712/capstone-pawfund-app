// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationInitialEvent extends AuthenticationEvent {}

class AuthenticationShowLoginEvent extends AuthenticationEvent {}

class AuthenticationShowRegisterEvent extends AuthenticationEvent {}

class RegisterSelectGenderEvent extends AuthenticationEvent {
  final String gender;

  const RegisterSelectGenderEvent({required this.gender});
}

class SendVerificationAccountEvent extends AuthenticationEvent {
  final String email;

  SendVerificationAccountEvent({required this.email});
}

class VerificationAccountCodeEvent extends AuthenticationEvent {
  final AccountModel accountModel;
  final String verificationCode;

  VerificationAccountCodeEvent(
      {required this.accountModel, required this.verificationCode});
}

class AuthenticationRegisterEvent extends AuthenticationEvent {
  final AccountModel accountModel;
  AuthenticationRegisterEvent({
    required this.accountModel,
  });
}
