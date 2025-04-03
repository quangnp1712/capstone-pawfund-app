part of 'profile_page_bloc.dart';

sealed class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object> get props => [];
}

class ProfilePageInitialEvent extends ProfilePageEvent {}

class ProfilePageLoadedEvent extends ProfilePageEvent {}

class ProfilePageUpdateProfileEvent extends ProfilePageEvent {
  final AccountModel account;

  ProfilePageUpdateProfileEvent({required this.account});
}
