part of 'menu_page_bloc.dart';

sealed class MenuPageEvent extends Equatable {
  const MenuPageEvent();

  @override
  List<Object> get props => [];
}

class MenuPageInitialEvent extends MenuPageEvent {}

class IsLoginEvent extends MenuPageEvent {}

class MenuPageShowMenuPageEvent extends MenuPageEvent {}

class MenuPageLogoutEvent extends MenuPageEvent {}

class MenuPageLoadedEvent extends MenuPageEvent {}
