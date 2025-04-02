import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/features/data/services/authentication_service.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageInitialEvent>(_homePageInitialEvent);
    on<IsLoginEvent>(_isLoginEvent);
    on<ShowLoginPageEvent>(_showLoginPageEvent);
  }

  FutureOr<void> _homePageInitialEvent(
      HomePageInitialEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageInitial());
    add(IsLoginEvent());
  }

  FutureOr<void> _isLoginEvent(
      IsLoginEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageLoadingState());
    try {
      final checkJwtExpired = await AuthenticationService().checkJwtExpired();
      if (!checkJwtExpired) {
        emit(IsLoginState(isLogin: true));
      } else {
        emit(IsLoginState(isLogin: false));
      }
    } catch (e) {
      emit(IsLoginState(isLogin: false));
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _showLoginPageEvent(
      ShowLoginPageEvent event, Emitter<HomePageState> emit) async {
    emit(ShowLoginPageState());
  }
}
