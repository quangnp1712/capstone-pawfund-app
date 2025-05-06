import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/core/utils/utf8_encoding.dart';
import 'package:capstone_pawfund_app/features/data/models/shelter_model.dart';
import 'package:capstone_pawfund_app/features/domain/repository/shelter_repo/shelter_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'shelter_page_event.dart';
part 'shelter_page_state.dart';

class ShelterPageBloc extends Bloc<ShelterPageEvent, ShelterPageState> {
  ShelterPageBloc() : super(ShelterPageInitial()) {
    on<ShelterPageInitialEvent>(_shelterPageInitialEvent);
    on<ShelterPageLoadedEvent>(_shelterPageLoadedEvent);
    on<ShelterPageShowShelterDetailEvent>(_shelterPageShowShelterDetailEvent);
    on<ShelterPageShowDonationPageEvent>(_shelterPageShowDonationPageEvent);
  }

  FutureOr<void> _shelterPageInitialEvent(
      ShelterPageInitialEvent event, Emitter<ShelterPageState> emit) {
    emit(ShelterPageInitial());
    add(ShelterPageLoadedEvent());
  }

  FutureOr<void> _shelterPageLoadedEvent(
      ShelterPageLoadedEvent event, Emitter<ShelterPageState> emit) async {
    emit(ShelterPageChangeState());
    emit(ShelterPageLoadingState(isLoading: true));
    emit(ShelterPageChangeState());

    try {
      final storage = FirebaseStorage.instance;
      var results = await ShelterRepository().getShelterList();
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      ShelterListResponse shelterResponse;

      if (responseSuccess) {
        shelterResponse = ShelterListResponse.fromJson(responseBody);
        if (shelterResponse.data != null) {
          for (var shelterItems in shelterResponse.data!) {
            try {
              shelterItems.shelterName =
                  Utf8Encoding().decode(shelterItems.shelterName.toString());
            } catch (e) {}
            try {
              shelterItems.address =
                  Utf8Encoding().decode(shelterItems.address.toString());
            } catch (e) {}
            try {
              shelterItems.hotline =
                  Utf8Encoding().decode(shelterItems.hotline.toString());
            } catch (e) {}
          }
          emit(ShelterPageLoadedState(shelterModel: shelterResponse.data!));
        } else {}
      } else {
        emit(ShelterPageLoadingState(isLoading: false));
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      emit(ShelterPageLoadingState(isLoading: false));
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _shelterPageShowShelterDetailEvent(
      ShelterPageShowShelterDetailEvent event,
      Emitter<ShelterPageState> emit) async {
    emit(ShelterPageChangeState());
    emit(ShelterPageLoadingState(isLoading: true));
    emit(ShelterPageChangeState());

    try {
      final storage = FirebaseStorage.instance;
      var results = await ShelterRepository().getShelterDetail(event.shelterId);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      ShelterDetailResponse shelterDetailResponse;

      if (responseSuccess) {
        shelterDetailResponse = ShelterDetailResponse.fromJson(responseBody);
        if (shelterDetailResponse.data != null) {
          try {
            shelterDetailResponse.data!.shelterName = Utf8Encoding()
                .decode(shelterDetailResponse.data!.shelterName.toString());
          } catch (e) {}
          try {
            shelterDetailResponse.data!.address = Utf8Encoding()
                .decode(shelterDetailResponse.data!.address.toString());
          } catch (e) {}
          try {
            shelterDetailResponse.data!.hotline = Utf8Encoding()
                .decode(shelterDetailResponse.data!.hotline.toString());
          } catch (e) {}

          emit(ShelterPageShowShelterDetailPageState(
              shelterDetail: shelterDetailResponse.data!));
        } else {
          emit(ShelterPageLoadingState(isLoading: false));
        }
      } else {
        emit(ShelterPageLoadingState(isLoading: false));
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      emit(ShelterPageLoadingState(isLoading: false));
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _shelterPageShowDonationPageEvent(
      ShelterPageShowDonationPageEvent event, Emitter<ShelterPageState> emit) {
    emit(ShelterPageChangeState());
    emit(ShelterPageShowDonationPageState());
  }
}
