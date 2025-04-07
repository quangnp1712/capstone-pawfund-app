import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';
import 'package:capstone_pawfund_app/features/presentation/change_email_page/bloc/change_email_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/dialog/loading_dialog.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/landing_navigation_bottom/landing_navigation_bottom.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();

  static const String ChangeEmailPageRoute = "/change_email";
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final ChangeEmailPageBloc changeEmailPageBloc = ChangeEmailPageBloc();
  CloseDialog? _closeDialogHandle;
  ShowDialog? _showDialogHandle;

  final _formKey = GlobalKey<FormState>();
  TextEditingController oldEmailController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  bool isVerifyCode = false;

  @override
  void initState() {
    oldEmailController.text = AuthPref.getEmail();
    changeEmailPageBloc.add(ChangeEmailPageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<ChangeEmailPageBloc, ChangeEmailPageState>(
      bloc: changeEmailPageBloc,
      listenWhen: (previous, current) => current is ChangeEmailPageActionState,
      buildWhen: (previous, current) => current is! ChangeEmailPageActionState,
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
          case ChangeEmailPageLoadingState:
            final currentState = state as ChangeEmailPageLoadingState;
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
        if (state is ChangeEmailPageVerificationCodeState) {
          isVerifyCode = true;
        }
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(size),
                    const SizedBox(height: 10),
                    _buildBodyLogin(size, isVerifyCode),
                  ],
                ),
              ),
            ),
          ),
        );
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
            const SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "THAY ĐỔI EMAIL",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                  onPressed: () {
                    Get.to(const LandingNavBottomWidget(
                      index: 0,
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyLogin(Size size, bool isVerifyCode) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 100.h,
      ),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF36439), Color(0xFFFFA726)],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset('assets/images/logo_1.png', height: size.height * 0.2),

            const SizedBox(height: 20),

            // Form
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    const Text(
                      "Thay đổi Email",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439),
                      ),
                    ),
                    const SizedBox(height: 5),

                    const Text(
                      'Sau khi thông tin email của bạn đã được cập nhật. '
                      'Vì lý do bảo mật, bạn sẽ được đăng xuất khỏi ứng dụng. '
                      '\nVui lòng đăng nhập lại để tiếp tục sử dụng dịch vụ.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // User Field
                    const Text(
                      "Email hiện tại",
                      style: TextStyle(
                          color: Color(0xFFF36439),
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: oldEmailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 0, end: 12),
                          child: Icon(
                            Icons.email,
                            color: Color(0xFFF36439),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Colors.grey), // Viền khi chưa focus
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 2), // Viền khi focus
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Password Field
                    const Text(
                      "Nhập email mới",
                      style: TextStyle(
                          color: Color(0xFFF36439),
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: newEmailController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        FilteringTextInputFormatter.deny(
                            RegExp(r'[^a-zA-Z0-9@._-]')),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 0, end: 12),
                          child: Icon(
                            Icons.email,
                            color: Color(0xFFF36439),
                          ),
                        ),
                        hintText: "Nhập email mới",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Colors.grey), // Viền khi chưa focus
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xFFF36439),
                              width: 2), // Viền khi focus
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(
                                  0xFFBD0D00)), // Bạn có thể thay màu lỗi tùy ý
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xFFBD0D00), width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập email mới";
                        }
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return "Email không hợp lệ";
                        }
                        return null;
                      },
                    ),
                    // verifyCode
                    isVerifyCode
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "Nhập mã xác thực",
                                style: TextStyle(
                                    color: Color(0xFFF36439),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextFormField(
                                controller: verificationCodeController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 0, end: 12),
                                    child: Icon(
                                      Icons.lock,
                                      color: Color(0xFFF36439),
                                    ),
                                  ),
                                  hintText: "Nhập mã xác thực",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color:
                                            Colors.grey), // Viền khi chưa focus
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFF36439),
                                        width: 2), // Viền khi focus
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(
                                            0xFFBD0D00)), // Bạn có thể thay màu lỗi tùy ý
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFBD0D00), width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng không để trống mã xác thực';
                                  } else if (!RegExp(r'^\d{6}$')
                                      .hasMatch(value)) {
                                    return 'Mã xác thực phải gồm 6 chữ số';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )
                        : Container(),

                    const SizedBox(height: 60),

                    // xác thực mã Button
                    isVerifyCode
                        ? SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  changeEmailPageBloc.add(
                                      ChangeEmailPageVerifyCodeEvent(
                                          code:
                                              verificationCodeController.text));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF36439),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Xác thực Email mới",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  changeEmailPageBloc.add(
                                      ChangeEmailPageSubmitEvent(
                                          newEmail: newEmailController.text));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF36439),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Thay đổi Email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
