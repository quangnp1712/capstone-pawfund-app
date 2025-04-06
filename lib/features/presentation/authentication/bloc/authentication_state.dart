// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

abstract class AuthenticationActionState extends AuthenticationState {}

class ShowLoginPageState extends AuthenticationState {
  final String? email;

  ShowLoginPageState({this.email});
}

class ShowSnackBarActionState extends AuthenticationActionState {
  final String message;
  final bool success;

  ShowSnackBarActionState({required this.success, required this.message});
}

class ShowRegisterPageState extends AuthenticationState {
  final String? gender;

  ShowRegisterPageState({this.gender});
}

class AuthenticationLoadingState extends AuthenticationActionState {
  final bool isLoading;

  AuthenticationLoadingState({required this.isLoading});
}

class AuthenticationChangeState extends AuthenticationActionState {}

class RegisterSuccessState extends AuthenticationActionState {}

class AuthenticationSuccessState extends AuthenticationActionState {
  final String token;

  AuthenticationSuccessState({required this.token});
}

class VerificationAccountState extends AuthenticationActionState {}

class ShowVerificationEmailState extends AuthenticationState {
  final String email;

  ShowVerificationEmailState({required this.email});
}
