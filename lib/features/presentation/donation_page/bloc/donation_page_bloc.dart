import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'donation_page_event.dart';
part 'donation_page_state.dart';

class DonationPageBloc extends Bloc<DonationPageEvent, DonationPageState> {
  DonationPageBloc() : super(DonationPageInitial()) {
    on<DonationPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
