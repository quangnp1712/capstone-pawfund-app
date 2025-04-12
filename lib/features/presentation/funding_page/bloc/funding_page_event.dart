part of 'funding_page_bloc.dart';

sealed class FundingPageEvent extends Equatable {
  const FundingPageEvent();

  @override
  List<Object> get props => [];
}

class FundingPageInitialEvent extends FundingPageEvent {}

class FundingPageShowFundingDetailEvent extends FundingPageEvent {}

class FundingPageShowDonationPageEvent extends FundingPageEvent {}
