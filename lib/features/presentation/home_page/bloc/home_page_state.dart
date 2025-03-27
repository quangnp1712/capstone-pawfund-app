part of 'home_page_bloc.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class HomePageInitial extends HomePageState {}

abstract class HomePageActionState extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class ShowLoginPageState extends HomePageActionState {}
