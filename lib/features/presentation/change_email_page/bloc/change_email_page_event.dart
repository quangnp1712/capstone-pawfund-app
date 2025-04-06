part of 'change_email_page_bloc.dart';

sealed class ChangeEmailPageEvent extends Equatable {
  const ChangeEmailPageEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailPageInitialEvent extends ChangeEmailPageEvent {}

class ChangeEmailPageSubmitEvent extends ChangeEmailPageEvent {
  final String newEmail;
  const ChangeEmailPageSubmitEvent({required this.newEmail});
}

class ChangeEmailPageVerifyCodeEvent extends ChangeEmailPageEvent {
  final String code;
  const ChangeEmailPageVerifyCodeEvent({required this.code});
}

class ChangeEmailPageLogoutEvent extends ChangeEmailPageEvent {}
