import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/features/data/services/authentication_service.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';
import 'package:capstone_pawfund_app/features/domain/repository/auth_repo/auth_repo.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/authentication_page.dart';
import 'package:capstone_pawfund_app/features/presentation/menu_page/menu_page.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'change_pass_page_event.dart';
part 'change_pass_page_state.dart';

class ChangePassPageBloc
    extends Bloc<ChangePassPageEvent, ChangePassPageState> {
  ChangePassPageBloc() : super(ChangePassPageInitial()) {
    on<ChangePassPageInitialEvent>(_changePassPageInitialEvent);
    on<ChangePassPageSubmitEvent>(_changePassPageSubmitEvent);
  }

  FutureOr<void> _changePassPageInitialEvent(
      ChangePassPageInitialEvent event, Emitter<ChangePassPageState> emit) {
    emit(ChangePassPageInitial());
  }

  FutureOr<void> _changePassPageSubmitEvent(ChangePassPageSubmitEvent event,
      Emitter<ChangePassPageState> emit) async {
    emit(ChangePassPageChangeState());
    emit(ChangePassPageLoadingState(isLoading: true));
    emit(ChangePassPageChangeState());

    try {
      final bool checkPassword =
          await AuthenticationService().checkPassord(event.oldPassword);
      if (checkPassword) {
        var results =
            await AuthenticationRepository().changePassword(event.newPassword);
        var responseMessage = results['message'];
        var responseStatus = results['status'];
        var responseSuccess = results['success'];
        var responseBody = results['body'];
        emit(ChangePassPageLoadingState(isLoading: false));

        if (responseSuccess) {
          AuthPref.setPassword(event.newPassword);
          emit(ShowSnackBarActionState(
              message: "Thay đổi mật khẩu thành công",
              success: responseSuccess));
          Get.back();
        } else {
          emit(ShowSnackBarActionState(
              message: responseMessage, success: responseSuccess));
        }
      } else {
        emit(ChangePassPageLoadingState(isLoading: false));

        emit(ShowSnackBarActionState(
            message: "Mật khẩu hiện tại không chính xác", success: false));
      }
    } catch (e) {
      emit(ChangePassPageLoadingState(isLoading: false));
      DebugLogger.printLog(e.toString());
    }
  }
}
