import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/features/data/services/authentication_service.dart';
import 'package:equatable/equatable.dart';

part 'menu_page_event.dart';
part 'menu_page_state.dart';

class MenuPageBloc extends Bloc<MenuPageEvent, MenuPageState> {
  MenuPageBloc() : super(MenuPageInitial()) {
    on<MenuPageInitialEvent>(_menuPageInitialEvent);
    on<IsLoginEvent>(_isLoginEvent);
    on<MenuPageShowMenuPageEvent>(_menuPageShowMenuPageEvent);
  }

  FutureOr<void> _menuPageInitialEvent(
      MenuPageInitialEvent event, Emitter<MenuPageState> emit) async {
    emit(MenuPageInitial());
    add(IsLoginEvent());
  }

  FutureOr<void> _isLoginEvent(
      IsLoginEvent event, Emitter<MenuPageState> emit) async {
    emit(MenuPageLoadingState());
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

  FutureOr<void> _menuPageShowMenuPageEvent(
      MenuPageShowMenuPageEvent event, Emitter<MenuPageState> emit) async {
    emit(ShowMenuPageState());
  }
}
