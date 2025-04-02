import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/features/data/models/account_model.dart';
import 'package:capstone_pawfund_app/features/domain/repository/auth_repo/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  AccountResponse _accountResponse = AccountResponse();

  ProfilePageBloc() : super(ProfilePageInitial()) {
    on<ProfilePageInitialEvent>(_profilePageInitialEvent);
    on<ProfilePageLoadedEvent>(_profilePageLoadedEvent);
  }
  FutureOr<void> _profilePageInitialEvent(
      ProfilePageInitialEvent event, Emitter<ProfilePageState> emit) {
    emit(ProfilePageInitial());
    add(ProfilePageLoadedEvent());
  }

  FutureOr<void> _profilePageLoadedEvent(
      ProfilePageLoadedEvent event, Emitter<ProfilePageState> emit) async {
    emit(ProfilePageLoadingPageState());
    try {
      var results = await AuthenticationRepository().selfDetail();

      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      AccountResponse accountResponse = AccountResponse();
      if (responseSuccess) {
        accountResponse = AccountResponse.fromJson(responseBody);
        _accountResponse = accountResponse;
        emit(ProfilePageLoadedState(accountResponse: accountResponse));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      DebugLogger.printLog(e.toString());
    }
  }
}
