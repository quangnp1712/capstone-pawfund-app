part of 'change_pass_page_bloc.dart';

sealed class ChangePassPageState extends Equatable {
  const ChangePassPageState();

  @override
  List<Object> get props => [];
}

final class ChangePassPageInitial extends ChangePassPageState {}

abstract class ChangePassPageActionState extends ChangePassPageState {}

class ChangePassPageLoadingState extends ChangePassPageActionState {
  final bool isLoading;

  ChangePassPageLoadingState({required this.isLoading});
}

class ChangePassPageChangeState extends ChangePassPageActionState {}

class ShowSnackBarActionState extends ChangePassPageActionState {
  final String message;
  final bool success;

  ShowSnackBarActionState({required this.success, required this.message});
}
