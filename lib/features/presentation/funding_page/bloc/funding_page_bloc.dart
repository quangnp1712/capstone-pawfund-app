import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'funding_page_event.dart';
part 'funding_page_state.dart';

class FundingPageBloc extends Bloc<FundingPageEvent, FundingPageState> {
  FundingPageBloc() : super(FundingPageInitial()) {
    on<FundingPageInitialEvent>(_FundingPageInitialEvent);
    on<FundingPageShowFundingDetailEvent>(_FundingPageShowFundingDetailEvent);
    on<FundingPageShowDonationPageEvent>(_FundingPageShowDonationPageEvent);
  }

  FutureOr<void> _FundingPageInitialEvent(
      FundingPageInitialEvent event, Emitter<FundingPageState> emit) {
    emit(FundingPageInitial());
  }

  FutureOr<void> _FundingPageShowFundingDetailEvent(
      FundingPageShowFundingDetailEvent event, Emitter<FundingPageState> emit) {
    emit(FundingPageChangeState());
    emit(FundingPageShowFundingDetailPageState());
  }

  FutureOr<void> _FundingPageShowDonationPageEvent(
      FundingPageShowDonationPageEvent event, Emitter<FundingPageState> emit) {
    emit(FundingPageChangeState());
    emit(FundingPageShowDonationPageState());
  }
}
