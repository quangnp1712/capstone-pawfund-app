// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/features/presentation/home_page/home_page.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/landing_navigation_bottom/landing_navigation_bottom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:capstone_pawfund_app/features/presentation/authentication/bloc/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  final AuthenticationBloc bloc;
  final String? email;
  const LoginPage({
    super.key,
    required this.bloc,
    this.email,
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    DebugLogger.printLog(Get.currentRoute);
    DebugLogger.printLog(Get.previousRoute);
    if (widget.email != null) {
      emailController.text = widget.email ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.back();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(size),
                  const SizedBox(height: 10),
                  _buildBodyLogin(size),
                ],
              ),
            ),
          ),
        ),
      ),
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
                "ĐĂNG NHẬP",
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

  Widget _buildBodyLogin(Size size) {
    return Container(
      width: double.infinity,
      // height: 100.h,
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
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset('assets/images/logo_1.png',
                  height: size.height * 0.2),

              const SizedBox(height: 20),

              // Form
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                        "Đăng nhập",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF36439),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // User Field
                      const Text(
                        "Email",
                        style: TextStyle(
                            color: Color(0xFFF36439),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng

                          FilteringTextInputFormatter.deny(
                              RegExp(r'[^a-zA-Z0-9@._-]')),
                        ],
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding:
                                EdgeInsetsDirectional.only(start: 0, end: 12),
                            child: Icon(
                              Icons.email,
                              color: Color(0xFFF36439),
                            ),
                          ),
                          hintText: "Nhập email",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Viền khi chưa focus
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFF36439),
                                width: 2), // Viền khi focus
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập email";
                          }
                          final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return "Email không hợp lệ";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Password Field
                      const Text(
                        "Mật khẩu",
                        style: TextStyle(
                            color: Color(0xFFF36439),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                        ],
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding:
                                EdgeInsetsDirectional.only(start: 0, end: 12),
                            child: Icon(
                              Icons.lock,
                              color: Color(0xFFF36439),
                            ),
                          ),
                          hintText: "Nhập mật khẩu",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Viền khi chưa focus
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFF36439),
                                width: 2), // Viền khi focus
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu ';
                          }
                          return null; // Trả về null nếu không có lỗi
                        },
                      ),
                      const SizedBox(height: 60),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.bloc.add(AuthenticationLoginEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF36439),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Đăng nhập",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // // Sign Up
                      // Center(
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child: const Text(
                      //       'Quên mật khẩu',
                      //       style: TextStyle(
                      //         color: Color(0xFFF36439),
                      //         decoration: TextDecoration.underline,
                      //         decorationColor: Color(0xFFF36439),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: const Text(
                              'Bạn chưa có tài khoản?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () => widget.bloc
                                .add(AuthenticationShowRegisterEvent()),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0), // Adjust padding
                            ),
                            child: const Text(
                              'Đăng ký',
                              style: TextStyle(
                                  color: Color(0xFFF36439),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
