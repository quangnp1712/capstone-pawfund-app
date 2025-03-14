import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adoption_page_event.dart';
part 'adoption_page_state.dart';

class AdoptionPageBloc extends Bloc<AdoptionPageEvent, AdoptionPageState> {
  AdoptionPageBloc() : super(AdoptionPageInitial()) {
    on<AdoptionPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
