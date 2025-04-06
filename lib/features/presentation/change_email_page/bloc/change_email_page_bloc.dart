import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';
import 'package:capstone_pawfund_app/features/domain/repository/auth_repo/auth_repo.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/authentication_page.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/landing_navigation_bottom/landing_navigation_bottom.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'change_email_page_event.dart';
part 'change_email_page_state.dart';

class ChangeEmailPageBloc
    extends Bloc<ChangeEmailPageEvent, ChangeEmailPageState> {
  String _newEmail = "";
  ChangeEmailPageBloc() : super(ChangeEmailPageInitial()) {
    on<ChangeEmailPageInitialEvent>(_changeEmailPageInitialEvent);
    on<ChangeEmailPageSubmitEvent>(_changeEmailPageSubmitEvent);
    on<ChangeEmailPageVerifyCodeEvent>(_changeEmailPageVerifyCodeEvent);
    on<ChangeEmailPageLogoutEvent>(_changeEmailPageLogoutEvent);
  }

  FutureOr<void> _changeEmailPageInitialEvent(
      ChangeEmailPageInitialEvent event, Emitter<ChangeEmailPageState> emit) {
    emit(ChangeEmailPageInitial());
  }

  FutureOr<void> _changeEmailPageSubmitEvent(ChangeEmailPageSubmitEvent event,
      Emitter<ChangeEmailPageState> emit) async {
    emit(ChangeEmailPageChangeState());
    emit(ChangeEmailPageLoadingState(isLoading: true));
    emit(ChangeEmailPageChangeState());

    try {
      var results = await AuthenticationRepository()
          .sendVerificationChangeEmail(event.newEmail);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      emit(ChangeEmailPageLoadingState(isLoading: false));

      if (responseSuccess) {
        _newEmail = event.newEmail;
        emit(ChangeEmailPageVerificationCodeState(isVerifyCode: true));
        emit(ShowSnackBarActionState(
            message: "Gửi mã xác thực thành công. Bạn hãy kiểm tra email!",
            success: responseSuccess));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      emit(ChangeEmailPageLoadingState(isLoading: false));
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _changeEmailPageVerifyCodeEvent(
      ChangeEmailPageVerifyCodeEvent event,
      Emitter<ChangeEmailPageState> emit) async {
    emit(ChangeEmailPageChangeState());
    emit(ChangeEmailPageLoadingState(isLoading: true));
    emit(ChangeEmailPageChangeState());

    try {
      var results = await AuthenticationRepository().changeEmail(event.code);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      emit(ChangeEmailPageLoadingState(isLoading: false));

      if (responseSuccess) {
        AuthPref.setEmail(_newEmail);
        emit(ShowSnackBarActionState(
            message: "Thay đổi Email thành công", success: responseSuccess));
        Get.back();
      } else if (responseStatus != null && responseStatus == 404) {
        emit(ShowSnackBarActionState(
            message: "Mã xác thực không đúng", success: responseSuccess));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      emit(ChangeEmailPageLoadingState(isLoading: false));
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _changeEmailPageLogoutEvent(ChangeEmailPageLogoutEvent event,
      Emitter<ChangeEmailPageState> emit) async {
    emit(ChangeEmailPageChangeState());

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
