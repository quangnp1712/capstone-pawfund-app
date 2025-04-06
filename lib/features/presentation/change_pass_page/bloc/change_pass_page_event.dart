part of 'change_pass_page_bloc.dart';

sealed class ChangePassPageEvent extends Equatable {
  const ChangePassPageEvent();

  @override
  List<Object> get props => [];
}

class ChangePassPageInitialEvent extends ChangePassPageEvent {}

class ChangePassPageSubmitEvent extends ChangePassPageEvent {
  final String oldPassword;
  final String newPassword;
  const ChangePassPageSubmitEvent(
      {required this.oldPassword, required this.newPassword});
}
