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
    on<ProfilePageUpdateProfileEvent>(_profilePageUpdateProfileEvent);
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
        emit(ProfilePageLoadedState(accountResponse: accountResponse.data!));
      } else {
        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      DebugLogger.printLog(e.toString());
    }
  }

  FutureOr<void> _profilePageUpdateProfileEvent(
      ProfilePageUpdateProfileEvent event,
      Emitter<ProfilePageState> emit) async {
    emit(ProfilePageLoadingPageState());
    final AccountModel accountUpdateFail = event.account;
    try {
      if (event.account.firstName == null || event.account.firstName == "") {
        event.account.firstName = _accountResponse.data?.firstName;
      }
      if (event.account.lastName == null || event.account.lastName == "") {
        event.account.lastName = _accountResponse.data?.lastName;
      }
      if (event.account.identification == null ||
          event.account.identification == "") {
        event.account.identification = _accountResponse.data?.identification;
      }
      if (event.account.phone == null || event.account.phone == "") {
        event.account.phone = _accountResponse.data?.phone;
      }
      if (event.account.address == null || event.account.address == "") {
        event.account.address = _accountResponse.data?.address;
      }
      if (event.account.dateOfBirth == null ||
          event.account.dateOfBirth == "") {
        event.account.dateOfBirth = _accountResponse.data?.dateOfBirth;
      }

      var results =
          await AuthenticationRepository().updateProfile(event.account);

      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseSuccess = results['success'];
      var responseBody = results['body'];
      AccountResponse accountResponse = AccountResponse();
      if (responseSuccess) {
        accountResponse = AccountResponse.fromJson(responseBody);
        _accountResponse = accountResponse;
        emit(ProfilePageLoadedState(accountResponse: accountResponse.data!));
        emit(ShowSnackBarActionState(
            message: "Cập nhập thông tin tài khoản thành công",
            success: responseSuccess));
      } else {
        emit(ProfilePageLoadedState(accountResponse: accountUpdateFail));

        emit(ShowSnackBarActionState(
            message: responseMessage, success: responseSuccess));
      }
    } catch (e) {
      emit(ProfilePageLoadedState(accountResponse: accountUpdateFail));

      DebugLogger.printLog(e.toString());
    }
  }
}
