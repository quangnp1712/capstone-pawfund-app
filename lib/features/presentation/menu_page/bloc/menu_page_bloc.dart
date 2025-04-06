// ignore_for_file: empty_catches

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/core/utils/utf8_encoding.dart';
import 'package:capstone_pawfund_app/features/data/models/account_model.dart';
import 'package:capstone_pawfund_app/features/data/services/authentication_service.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';
import 'package:capstone_pawfund_app/features/domain/repository/auth_repo/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'menu_page_event.dart';
part 'menu_page_state.dart';

class MenuPageBloc extends Bloc<MenuPageEvent, MenuPageState> {
  MenuPageBloc() : super(MenuPageInitial()) {
    on<MenuPageInitialEvent>(_menuPageInitialEvent);
    on<IsLoginEvent>(_isLoginEvent);
    on<MenuPageShowMenuPageEvent>(_menuPageShowMenuPageEvent);
    on<MenuPageLogoutEvent>(_menuPageLogoutEvent);
    on<MenuPageLoadedEvent>(_menuPageLoadedEvent);
  }

  FutureOr<void> _menuPageInitialEvent(
      MenuPageInitialEvent event, Emitter<MenuPageState> emit) async {
    emit(MenuPageInitial());
    add(IsLoginEvent());
  }

  FutureOr<void> _menuPageLoadedEvent(
      MenuPageLoadedEvent event, Emitter<MenuPageState> emit) async {
    emit(MenuPageLoadingPageState());
    try {
      final storage = FirebaseStorage.instance;

      var results = await AuthenticationRepository().selfDetail();

      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      AccountResponse accountResponse = AccountResponse();
      if (responseSuccess) {
        accountResponse = AccountResponse.fromJson(responseBody);
        // full name
        accountResponse.data?.name =
            "${accountResponse.data?.firstName} ${accountResponse.data?.lastName}";

        try {
          accountResponse.data?.name =
              Utf8Encoding().decode(accountResponse.data?.name ?? "");
        } on Exception {}

        // avatar url
        if (accountResponse.data!.medias != null) {
          for (var _media in accountResponse.data!.medias!) {
            if (_media.isThumbnail!) {
              try {
                var reference = storage.ref(_media.url);
                accountResponse.data?.avatarUrl =
                    await reference.getDownloadURL();
                break;
              } catch (e) {
                DebugLogger.printLog(e.toString());
              }
            }
          }
        }
        emit(
            MenuPageLoadedState(account: accountResponse.data!, isLogin: true));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _isLoginEvent(
      IsLoginEvent event, Emitter<MenuPageState> emit) async {
    emit(MenuPageLoadingPageState());

    try {
      final checkJwtExpired = await AuthenticationService().checkJwtExpired();
      if (!checkJwtExpired) {
        add(MenuPageLoadedEvent());
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

  FutureOr<void> _menuPageLogoutEvent(
      MenuPageLogoutEvent event, Emitter<MenuPageState> emit) async {
    emit(MenuPageLoadingState());
    try {
      var results = await AuthenticationRepository().logout();
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];

      if (responseSuccess) {
        emit(ShowSnackBarActionState(
            message: "Đăng xuất thành công", success: responseSuccess));
        AuthPref.logout();
      } else {
        AuthPref.logout();
        DebugLogger.printLog(responseMessage);
      }
    } catch (e) {}
  }
}
