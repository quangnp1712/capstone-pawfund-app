import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shelter_page_event.dart';
part 'shelter_page_state.dart';

class ShelterPageBloc extends Bloc<ShelterPageEvent, ShelterPageState> {
  ShelterPageBloc() : super(ShelterPageInitial()) {
    on<ShelterPageInitialEvent>(_shelterPageInitialEvent);
    on<ShelterPageShowShelterDetailEvent>(_shelterPageShowShelterDetailEvent);
    on<ShelterPageShowDonationPageEvent>(_shelterPageShowDonationPageEvent);
  }

  FutureOr<void> _shelterPageInitialEvent(
      ShelterPageInitialEvent event, Emitter<ShelterPageState> emit) {
    emit(ShelterPageInitial());
  }

  FutureOr<void> _shelterPageShowShelterDetailEvent(
      ShelterPageShowShelterDetailEvent event, Emitter<ShelterPageState> emit) {
    emit(ShelterPageChangeState());
    emit(ShelterPageShowShelterDetailPageState());
  }

  FutureOr<void> _shelterPageShowDonationPageEvent(
      ShelterPageShowDonationPageEvent event, Emitter<ShelterPageState> emit) {
    emit(ShelterPageChangeState());
    emit(ShelterPageShowDonationPageState());
  }
}
