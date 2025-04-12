part of 'shelter_page_bloc.dart';

sealed class ShelterPageEvent extends Equatable {
  const ShelterPageEvent();

  @override
  List<Object> get props => [];
}

class ShelterPageInitialEvent extends ShelterPageEvent {}

class ShelterPageShowShelterDetailEvent extends ShelterPageEvent {}

class ShelterPageShowDonationPageEvent extends ShelterPageEvent {}
