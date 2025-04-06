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
  AuthenticationPage({
    Key? key,
  }) : super(key: key);

  static const String AuthenticationPageRoute = "/auth";

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
          case AuthenticationLoadingState:
            final currentState = state as AuthenticationLoadingState;
            if (!currentState.isLoading) {
              _closeDialogHandle = closeLoadingDialog(context: context);
              _closeDialogHandle!(); // Gọi ngay
              _closeDialogHandle = null;
              _showDialogHandle = null;
            } else if (currentState.isLoading) {
              _showDialogHandle = showLoadingDialog(context: context);
              _showDialogHandle!(); // Gọi ngay
            }
            break;
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ShowLoginPageState:
            final currentState = state as ShowLoginPageState;
            return LoginPage(
              bloc: authPageBloc,
              email: currentState.email,
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
