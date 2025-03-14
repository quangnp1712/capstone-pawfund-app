import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'funding_page_event.dart';
part 'funding_page_state.dart';

class FundingPageBloc extends Bloc<FundingPageEvent, FundingPageState> {
  FundingPageBloc() : super(FundingPageInitial()) {
    on<FundingPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
