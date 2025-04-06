part of 'change_email_page_bloc.dart';

sealed class ChangeEmailPageState extends Equatable {
  const ChangeEmailPageState();

  @override
  List<Object> get props => [];
}

final class ChangeEmailPageInitial extends ChangeEmailPageState {}

abstract class ChangeEmailPageActionState extends ChangeEmailPageState {}

class ChangeEmailPageLoadingState extends ChangeEmailPageActionState {
  final bool isLoading;

  ChangeEmailPageLoadingState({required this.isLoading});
}

class ChangeEmailPageChangeState extends ChangeEmailPageActionState {}

class ShowSnackBarActionState extends ChangeEmailPageActionState {
  final String message;
  final bool success;

  ShowSnackBarActionState({required this.success, required this.message});
}

class ChangeEmailPageVerificationCodeState extends ChangeEmailPageState {
  final bool isVerifyCode;

  ChangeEmailPageVerificationCodeState({required this.isVerifyCode});
}
