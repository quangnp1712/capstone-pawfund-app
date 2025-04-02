part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class HomePageInitialEvent extends HomePageEvent {}

class ShowLoginPageEvent extends HomePageEvent {}

class IsLoginEvent extends HomePageEvent {}
