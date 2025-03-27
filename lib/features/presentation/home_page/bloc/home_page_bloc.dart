import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageInitialEvent>(_homePageInitialEvent);
    on<ShowLoginPageEvent>(_showLoginPageEvent);
  }

  FutureOr<void> _homePageInitialEvent(
      HomePageInitialEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageInitial());
  }

  FutureOr<void> _showLoginPageEvent(
      ShowLoginPageEvent event, Emitter<HomePageState> emit) async {
    emit(ShowLoginPageState());
  }
}
