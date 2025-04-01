import 'package:capstone_pawfund_app/features/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/landing_navigation_bottom/landing_navigation_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class VerifictionEmailPage extends StatefulWidget {
  final AuthenticationBloc bloc;
  final String email;
  VerifictionEmailPage({super.key, required this.bloc, required this.email});

  @override
  State<VerifictionEmailPage> createState() => _VerifictionEmailPageState();

  static const String VerifictionEmailPageRoute = "/verification-email";
}

class _VerifictionEmailPageState extends State<VerifictionEmailPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  @override
  void initState() {
    emailController.text = widget.email;
    print('Current Route: ${Get.currentRoute}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                _buildBodyLogin(size),
              ],
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
                "XÁC THỰC EMAIL",
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
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    const Text(
                      "Xác thực Email",
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
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 0, end: 12),
                          child: Icon(
                            Icons.email,
                            color: Color(0xFFF36439),
                          ),
                        ),
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
                    ),
                    const SizedBox(height: 10),

                    // Password Field
                    const Text(
                      "Mã xác thực",
                      style: TextStyle(
                          color: Color(0xFFF36439),
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: verificationCodeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),

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
                        hintText: "Nhập mã xác thực",
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
                          return 'Vui lòng không để trống mã xác thực';
                        } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                          return 'Mã xác thực phải gồm 6 chữ số';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 60),

                    // xác thực mã Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.bloc.add(VerificationAccountCodeEvent(
                                route: "REGISTER",
                                email: emailController.text,
                                verificationCode:
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
                          "Xác thực",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Sign Up
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Gửi lại mã xác thực Email',
                          style: TextStyle(
                            color: Color(0xFFF36439),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFF36439),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn chưa có tài khoản?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () => widget.bloc
                              .add(AuthenticationShowRegisterEvent()),
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
    );
  }
}
