// ignore_for_file: unused_field

import 'package:capstone_pawfund_app/features/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/login_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/register_page.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/dialog/loading_dialog.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  static const String AuthenticationPageRoute = "/auth-screen";

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final AuthenticationBloc authPageBloc = AuthenticationBloc();
  CloseDialog? _closeDialogHandle;
  ShowDialog? _showDialogHandle;

  @override
  void initState() {
    authPageBloc.add(AuthenticationInitialEvent());
    print('Current Route: ${Get.currentRoute}');

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
          case AuthPageInvalidPhoneActionState:
            ShowSnackBar.ErrorSnackBar(context, "Số điện thoại không đúng");
            break;

          case AuthPageInvalidOtpActionState:
            ShowSnackBar.ErrorSnackBar(context, "Mã xác thực không đúng");
            break;

          case ShowSnackBarActionState:
            final snackBarState = state as ShowSnackBarActionState;
            if (snackBarState.status == true) {
              ShowSnackBar.SuccessSnackBar(context, snackBarState.message);
            } else {
              ShowSnackBar.ErrorSnackBar(context, snackBarState.message);
            }
            break;

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
          // case ShowCreateOtpPageState:
          //   final currentState = state as ShowCreateOtpPageState;
          //   return CreateOtpPage(bloc: authPageBloc, phone: currentState.phone);
          case ShowLoginPageState:
            return LoginPage(bloc: authPageBloc);
          case ShowRegisterPageState:
            bool isVerificationAccountState = false;
            if (state is VerificationAccountState) {
              isVerificationAccountState = true;
            }
            return RegisterPage(
                bloc: authPageBloc,
                isVerificationAccountState: isVerificationAccountState);
        }
        return const SizedBox();
      },
    );
  }
}
