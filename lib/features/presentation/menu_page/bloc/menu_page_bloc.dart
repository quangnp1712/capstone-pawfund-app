import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_page_event.dart';
part 'menu_page_state.dart';

class MenuPageBloc extends Bloc<MenuPageEvent, MenuPageState> {
  MenuPageBloc() : super(MenuPageInitial()) {
    on<MenuPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
