import 'package:capstone_pawfund_app/features/data/models/account_model.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  final AuthenticationBloc bloc;
  RegisterPage({
    super.key,
    required this.bloc,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();

  static const String RegisterPageRoute = "/register";
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cccdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  DateTime? dobSubmit;
  List<String> genders = ['NAM', 'NỮ'];
  String genderController = 'NAM';

  @override
  void initState() {
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
            SizedBox(
              height: 50,
              child: IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  // Xử lý khi bấm vào biểu tượng thông báo
                },
              ),
            ),
            const SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "ĐĂNG KÝ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyLogin(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 20),
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
                    "Đăng ký",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF36439),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // họ Field
                  const Text(
                    "Họ",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  TextFormField(
                    controller: firstNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
                        child: Icon(
                          Icons.person,
                          color: Color(0xFFF36439),
                        ),
                      ),
                      hintText: "Nhập họ",
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
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng không để trống Họ của bạn';
                      }

                      return null; // Trả về null nếu không có lỗi
                    },
                  ),
                  const SizedBox(height: 10),

                  // tên Field
                  const Text(
                    "Tên",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  TextFormField(
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
                        child: Icon(
                          Icons.person_outline,
                          color: Color(0xFFF36439),
                        ),
                      ),
                      hintText: "Nhập tên",
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
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng không để trống Tên của bạn';
                      }

                      return null; // Trả về null nếu không có lỗi
                    },
                  ),
                  const SizedBox(height: 10),

                  // cccd Field
                  const Text(
                    "Căn cước công dân",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  TextFormField(
                    controller: cccdController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
                        child: Icon(
                          Icons.credit_card,
                          color: Color(0xFFF36439),
                        ),
                      ),
                      hintText: "Nhập căn cước công dân",
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
                        return 'Vui lòng không để trống cccd của bạn';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // sđt Field
                  const Text(
                    "Số điện thoại",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  TextFormField(
                    controller: phoneController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
                        child: Icon(
                          Icons.phone,
                          color: Color(0xFFF36439),
                        ),
                      ),
                      hintText: "Nhập số điện thoại",
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
                        return 'Vui lòng không để trống số điện thoại của bạn';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // địa chỉ Field
                  const Text(
                    "Địa chỉ",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  TextFormField(
                    controller: addressController,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
                        child: Icon(
                          Icons.home,
                          color: Color(0xFFF36439),
                        ),
                      ),
                      hintText: "Nhập địa chỉ",
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

                  // ngày sinh Field
                  const Text(
                    "Ngày sinh",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  TextFormField(
                    controller: dobController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
                        child: Icon(
                          Icons.calendar_today,
                          color: Color(0xFFF36439),
                        ),
                      ),
                      hintText: "Nhập Ngày sinh dd/mm/yyyy",
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
                    onTap:
                        //_selectDate, EVENT
                        () async {
                      DateTime? dob = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (dob != null) {
                        dobSubmit = dob;
                        dobController.text = DateFormat('yyyy-MM-dd')
                            .format(dob)
                            .toString()
                            .split(" ")[0];
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng không để trống Ngày sinh của bạn';
                      }

                      return null; // Trả về null nếu không có lỗi
                    },
                  ),
                  const SizedBox(height: 10),

                  // gới tính Field
                  const Text(
                    "Giới tính",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),

                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
                        child: Icon(
                          Icons.person, // Thay icon phù hợp với giới tính
                          color: Color(0xFFF36439),
                        ),
                      ),
                      hintText: "Chọn giới tính",
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
                    value: genderController, // Giá trị đã chọn
                    items: genders.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: const TextStyle(fontSize: 16)),
                      );
                    }).toList(),
                    onChanged: (item) {
                      genderController = item!;
                      // widget.bloc.add(
                      //     RegisterSelectGenderEvent(gender: genderController));
                    },
                  ),

                  const SizedBox(height: 10),

                  // email Field
                  const Text(
                    "Email",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  TextFormField(
                    controller: emailController,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng

                      FilteringTextInputFormatter.deny(
                          RegExp(r'[^a-zA-Z0-9@._-]')),
                    ],
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
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

                  // pass Field
                  const Text(
                    "Mật khẩu",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
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
                        return 'Vui lòng nhập mật khẩu';
                      }
                      return null; // Trả về null nếu không có lỗi
                    },
                  ),
                  const SizedBox(height: 10),

                  // Mật khẩu Field
                  const Text(
                    "Nhập lại mật khẩu",
                    style: TextStyle(
                        color: Color(0xFFF36439),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0, end: 12),
                        child: Icon(
                          Icons.lock_outline,
                          color: Color(0xFFF36439),
                        ),
                      ),
                      hintText: "Nhập lại mật khẩu",
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
                        return 'Vui lòng nhập lại mật khẩu';
                      }
                      if (value != passwordController.text) {
                        return 'Mật khẩu không khớp';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        String genderCode = "MALE";
                        if (genderController == "NAM") {
                          genderCode = "FEMALE";
                        }
                        AccountModel accountModel = AccountModel(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            identification: cccdController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            dateOfBirth: dobController.text,
                            genderName: genderController,
                            genderCode: genderCode);

                        widget.bloc.add(AuthenticationRegisterEvent(
                          accountModel: accountModel,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF36439),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Đăng ký",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bạn đã có tài khoản?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          return widget.bloc
                              .add(AuthenticationShowLoginEvent());
                        },
                        child: const Text(
                          'Đăng nhập',
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
    );
  }
}
