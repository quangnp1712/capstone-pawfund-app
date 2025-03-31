// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationInitialEvent extends AuthenticationEvent {
  final String routeTo;
  final String routeFrom;

  AuthenticationInitialEvent({required this.routeTo, required this.routeFrom});
}

class AuthenticationShowLoginEvent extends AuthenticationEvent {}

class AuthenticationShowRegisterEvent extends AuthenticationEvent {}

class SendVerificationAccountEvent extends AuthenticationEvent {
  final String email;

  SendVerificationAccountEvent({required this.email});
}

class VerificationAccountCodeEvent extends AuthenticationEvent {
  final String email;
  final String verificationCode;
  final String route;

  VerificationAccountCodeEvent(
      {required this.email,
      required this.verificationCode,
      required this.route});
}

class AuthenticationRegisterEvent extends AuthenticationEvent {
  final AccountModel accountModel;
  AuthenticationRegisterEvent({
    required this.accountModel,
  });
}

class AuthenticationLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationLoginEvent({
    required this.email,
    required this.password,
  });
}

class ShowVerificationEmail extends AuthenticationEvent {
  final String email;

  ShowVerificationEmail({required this.email});
}
