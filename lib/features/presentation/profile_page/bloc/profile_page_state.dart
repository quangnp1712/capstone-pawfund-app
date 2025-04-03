part of 'profile_page_bloc.dart';

sealed class ProfilePageState extends Equatable {
  const ProfilePageState();

  @override
  List<Object> get props => [];
}

final class ProfilePageInitial extends ProfilePageState {}

abstract class ProfilePageActionState extends ProfilePageState {}

class ProfilePageLoadingState extends ProfilePageActionState {}

class ProfilePageLoadingPageState extends ProfilePageState {}

class ProfilePageLoadedState extends ProfilePageState {
  final AccountModel accountResponse;

  ProfilePageLoadedState({required this.accountResponse});
}

class ShowSnackBarActionState extends ProfilePageActionState {
  final String message;
  final bool success;

  ShowSnackBarActionState({required this.success, required this.message});
}
