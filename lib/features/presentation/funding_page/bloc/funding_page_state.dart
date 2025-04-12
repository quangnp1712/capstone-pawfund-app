part of 'funding_page_bloc.dart';

sealed class FundingPageState extends Equatable {
  const FundingPageState();

  @override
  List<Object> get props => [];
}

final class FundingPageInitial extends FundingPageState {}

abstract class FundingPageActionState extends FundingPageState {}

class ShowSnackBarActionState extends FundingPageActionState {
  final String message;
  final bool success;

  ShowSnackBarActionState({required this.success, required this.message});
}

class FundingPageLoadingState extends FundingPageActionState {
  final bool isLoading;

  FundingPageLoadingState({required this.isLoading});
}

class FundingPageChangeState extends FundingPageActionState {}

class FundingPageShowFundingDetailPageState extends FundingPageActionState {}

class FundingPageShowDonationPageState extends FundingPageActionState {}
