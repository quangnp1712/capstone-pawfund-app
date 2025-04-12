part of 'donation_page_bloc.dart';

sealed class DonationPageState extends Equatable {
  const DonationPageState();

  @override
  List<Object> get props => [];
}

final class DonationPageInitial extends DonationPageState {}

abstract class DonationPageActionState extends DonationPageState {}

class DonationPageLoadingState extends DonationPageActionState {
  final bool isLoading;

  DonationPageLoadingState({required this.isLoading});
}

class DonationPageChangeState extends DonationPageActionState {}

class ShowSnackBarActionState extends DonationPageActionState {
  final String message;
  final bool success;

  ShowSnackBarActionState({required this.success, required this.message});
}
