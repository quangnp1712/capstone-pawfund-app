part of 'shelter_page_bloc.dart';

sealed class ShelterPageEvent extends Equatable {
  const ShelterPageEvent();

  @override
  List<Object> get props => [];
}

class ShelterPageInitialEvent extends ShelterPageEvent {}

class ShelterPageShowShelterDetailEvent extends ShelterPageEvent {
  final int shelterId;

  ShelterPageShowShelterDetailEvent({required this.shelterId});
}

class ShelterPageShowDonationPageEvent extends ShelterPageEvent {}

class ShelterPageLoadedEvent extends ShelterPageEvent {}
