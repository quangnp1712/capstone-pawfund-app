part of 'shelter_page_bloc.dart';

sealed class ShelterPageState extends Equatable {
  const ShelterPageState();

  @override
  List<Object> get props => [];
}

final class ShelterPageInitial extends ShelterPageState {}

abstract class ShelterPageActionState extends ShelterPageState {}

class ShowSnackBarActionState extends ShelterPageActionState {
  final String message;
  final bool success;

  ShowSnackBarActionState({required this.success, required this.message});
}

class ShelterPageLoadingState extends ShelterPageActionState {
  final bool isLoading;

  ShelterPageLoadingState({required this.isLoading});
}

class ShelterPageChangeState extends ShelterPageActionState {}

class ShelterPageShowShelterDetailPageState extends ShelterPageActionState {}

class ShelterPageShowDonationPageState extends ShelterPageActionState {}
