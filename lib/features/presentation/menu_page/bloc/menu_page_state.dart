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
