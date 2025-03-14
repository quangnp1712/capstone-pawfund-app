import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shelter_page_event.dart';
part 'shelter_page_state.dart';

class ShelterPageBloc extends Bloc<ShelterPageEvent, ShelterPageState> {
  ShelterPageBloc() : super(ShelterPageInitial()) {
    on<ShelterPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
