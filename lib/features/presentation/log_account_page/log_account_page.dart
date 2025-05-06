import 'package:capstone_pawfund_app/features/presentation/log_account_page/bloc/log_account_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LogAccountPage extends StatefulWidget {
  const LogAccountPage({super.key});

  @override
  State<LogAccountPage> createState() => _LogAccountPageState();
}

class _LogAccountPageState extends State<LogAccountPage> {
  LogAccountPageBloc donationPageBloc = LogAccountPageBloc();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<LogAccountPageBloc, LogAccountPageState>(
      bloc: donationPageBloc,
      // listenWhen: (previous, current) => current is LogAccountPageActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          // case ShowSnackBarActionState:
          //   final snackBarState = state as ShowSnackBarActionState;
          //   if (snackBarState.success == true) {
          //     ShowSnackBar.SuccessSnackBar(context, snackBarState.message);
          //   } else {
          //     ShowSnackBar.ErrorSnackBar(context, snackBarState.message);
          //   }
          //   break;
        }
      },
      builder: (context, state) {
        return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {}
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 1) header
                      _buildHeader(size),
                      const SizedBox(height: 20),

                      // 2) Phần nội dung bên dưới
                      // _buildBody(size, mainOrangeColor),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget _buildHeader(Size size) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepOrangeAccent, Color(0xFFFFA726)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 50,
                child: IconButton(
                  alignment: Alignment.center,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "ủng hộ".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 50,
                child: IconButton(
                  alignment: Alignment.center,
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
