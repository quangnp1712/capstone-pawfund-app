// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_field

import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:capstone_pawfund_app/features/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/login_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/register_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/verifiction_email_page.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/dialog/loading_dialog.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/snackbar/snackbar.dart';

class AuthenticationPage extends StatefulWidget {
  String? route;
  AuthenticationPage({
    Key? key,
    this.route,
  }) : super(key: key);

  static const String AuthenticationPageRoute = "/auth";

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final AuthenticationBloc authPageBloc = AuthenticationBloc();
  String routeTo = "";
  String routeFrom = "";
  CloseDialog? _closeDialogHandle;
  ShowDialog? _showDialogHandle;

  @override
  void initState() {
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      routeTo = Get.arguments['routeTo'] ?? "";
      routeFrom = Get.arguments['routeFrom'] ?? "";
    }
    authPageBloc.add(
        AuthenticationInitialEvent(routeTo: routeTo, routeFrom: routeFrom));
    DebugLogger.printLog('Current Route: ${Get.currentRoute}');
    DebugLogger.printLog('Route History: ${Get.routing.previous}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: authPageBloc,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      buildWhen: (previous, current) => current is! AuthenticationActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ShowSnackBarActionState:
            final snackBarState = state as ShowSnackBarActionState;
            if (snackBarState.success == true) {
              ShowSnackBar.SuccessSnackBar(context, snackBarState.message);
            } else {
              ShowSnackBar.ErrorSnackBar(context, snackBarState.message);
            }
            break;

          // case ShowLoginPageState:
          //   // return LoginPage(
          //   //   bloc: authPageBloc,
          //   // );
          //   Get.toNamed(LoginPage.LoginPageRoute);
          //   break;

          // case AuthenticationSuccessState:
          //   final successState = state as AuthenticationSuccessState;
          //   print("token:${successState.token}");
          //   Get.offAllNamed(LandingPage.LandingPageRoute,
          //       arguments: {'token': successState.token});
          //   break;

          // case ShowLandingPageState:
          //   Get.offAllNamed(LandingPage.LandingPageRoute);
          //   break;
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ShowLoginPageState:
            return LoginPage(
              bloc: authPageBloc,
            );
          case ShowRegisterPageState:
            return RegisterPage(
              bloc: authPageBloc,
            );
          case ShowVerificationEmailState:
            ShowVerificationEmailState currentState =
                state as ShowVerificationEmailState;
            return VerifictionEmailPage(
              email: currentState.email,
              bloc: authPageBloc,
            );
        }
        return const SizedBox();
      },
    );
  }
}
