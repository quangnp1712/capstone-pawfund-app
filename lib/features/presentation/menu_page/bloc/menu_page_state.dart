part of 'menu_page_bloc.dart';

sealed class MenuPageState extends Equatable {
  const MenuPageState();

  @override
  List<Object> get props => [];
}

final class MenuPageInitial extends MenuPageState {}

abstract class MenuPageActionState extends MenuPageState {}

class MenuPageLoadingState extends MenuPageState {}

class ShowMenuPageState extends MenuPageState {}

class IsLoginState extends MenuPageState {
  final bool isLogin;

  IsLoginState({required this.isLogin});
}

class ShowSnackBarActionState extends MenuPageActionState {
  final String message;
  final bool success;

  ShowSnackBarActionState({required this.success, required this.message});
}

class MenuPageLoadingPageState extends MenuPageState {}

class MenuPageLoadedState extends MenuPageState {
  final AccountModel account;
  final bool isLogin;

  MenuPageLoadedState({required this.account, required this.isLogin});
}
