import 'package:capstone_pawfund_app/core/utils/utf8_encoding.dart';
import 'package:capstone_pawfund_app/features/data/models/account_model.dart';
import 'package:capstone_pawfund_app/features/presentation/profile_page/bloc/profile_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/landing_navigation_bottom/landing_navigation_bottom.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  static const String ProfilePageRoute = "/profile";
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfilePageBloc profilePageBloc = ProfilePageBloc();

  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController cccdController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController dobController = TextEditingController(text: "");
  TextEditingController verificationCodeController =
      TextEditingController(text: "");
  DateTime? dobSubmit;
  List<String> genders = ['NAM', 'NỮ'];
  String genderController = 'NAM';
  String? avatarUrl;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    profilePageBloc.add(ProfilePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<ProfilePageBloc, ProfilePageState>(
      bloc: profilePageBloc,
      listenWhen: (previous, current) => current is ProfilePageActionState,
      buildWhen: (previous, current) => current is! ProfilePageActionState,
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
        }
      },
      builder: (context, state) {
        if (state is ProfilePageLoadedState) {
          final currentState = state as ProfilePageLoadedState;
          try {
            firstNameController = TextEditingController(
                text: Utf8Encoding()
                    .decode(currentState.accountResponse.firstName.toString()));
          } catch (e) {
            firstNameController = TextEditingController(
                text: currentState.accountResponse.firstName.toString());
          }

          try {
            lastNameController = TextEditingController(
                text: Utf8Encoding()
                    .decode(currentState.accountResponse.lastName.toString()));
          } on Exception catch (e) {
            lastNameController = TextEditingController(
                text: currentState.accountResponse.lastName.toString());
          }
          try {
            cccdController = TextEditingController(
                text: Utf8Encoding().decode(
                    currentState.accountResponse.identification.toString()));
          } on Exception catch (e) {
            cccdController = TextEditingController(
                text: currentState.accountResponse.identification.toString());
          }
          try {
            phoneController = TextEditingController(
                text: Utf8Encoding()
                    .decode(currentState.accountResponse.phone.toString()));
          } on Exception catch (e) {
            phoneController = TextEditingController(
                text: currentState.accountResponse.phone.toString());
          }
          try {
            addressController = TextEditingController(
                text: Utf8Encoding()
                    .decode(currentState.accountResponse.address.toString()));
          } on Exception catch (e) {
            addressController = TextEditingController(
                text: currentState.accountResponse.address.toString());
          }
          try {
            emailController = TextEditingController(
                text: Utf8Encoding()
                    .decode(currentState.accountResponse.email.toString()));
          } on Exception catch (e) {
            emailController = TextEditingController(
                text: currentState.accountResponse.email.toString());
          }
          try {
            dobController = TextEditingController(
                text: Utf8Encoding().decode(
                    currentState.accountResponse.dateOfBirth.toString()));
          } on Exception catch (e) {
            dobController = TextEditingController(
                text: currentState.accountResponse.dateOfBirth.toString());
          }
          try {
            genderController = Utf8Encoding()
                .decode(currentState.accountResponse.genderName.toString());
          } on Exception catch (e) {
            genderController =
                currentState.accountResponse.genderName.toString();
          }
        }
        return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {}
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeader(size),
                      const SizedBox(height: 20),
                      state is ProfilePageLoadedState
                          ? _buildProfileInfo(size)
                          : _buildLoadingPage(),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget _buildLoadingPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          height: 50,
          width: 50,
          child: const CircularProgressIndicator(),
        )
      ],
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
                "Xem và Chỉnh sửa thông tin".toUpperCase(),
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
                  onPressed: () {
                    Get.to(const LandingNavBottomWidget(
                      index: 4,
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

  Widget _buildProfileInfo(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ảnh đại diện
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    child: ClipOval(
                      child: avatarUrl != null
                          ? CachedNetworkImage(
                              imageUrl: avatarUrl!,
                              // placeholder: (context, url) =>
                              //     const CircularProgressIndicator(),
                              fit: BoxFit.cover,
                              // width: 120,
                              // height: 120,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/avatar.png",
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            )
                          : Image.asset(
                              "assets/images/avatar.png",
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: Container(
                    height: 35,
                    width: 35,
                    child: const CircleAvatar(
                      child: ClipOval(
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            //
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Họ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: firstNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText: "Để trống, họ sẽ không thay đổi",
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
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tên",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText: "Để trống, Tên sẽ không thay đổi",
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
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Căn cước công dân",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: cccdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText:
                          "Để trống, căn cước công dân sẽ không thay đổi ",
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
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: emailController,
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Colors.grey), // Viền khi chưa focus
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ), // Viền khi focus
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Số điện thoại",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText: "Để trống, Số điện thoại sẽ không thay đổi ",
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
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Số điện thoại phải gồm 10 chữ số';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Địa chỉ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: addressController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText: "Để trống, Địa chỉ sẽ không thay đổi ",
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
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ngày sinh",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: dobController,
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText: "Để trống, Ngày sinh sẽ không thay đổi ",
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
                    onTap:
                        //_selectDate, EVENT
                        () async {
                      DateTime now = DateTime.now();
                      DateTime minSelectableDate = DateTime(now.year - 100);
                      DateTime maxSelectableDate = DateTime(now.year - 14);
                      DateTime? dob = await showDatePicker(
                        context: context,
                        initialDate: maxSelectableDate,
                        firstDate: minSelectableDate,
                        lastDate: maxSelectableDate,
                      );
                      if (dob != null) {
                        dobSubmit = dob;
                        dobController.text = DateFormat('yyyy-MM-dd')
                            .format(dob)
                            .toString()
                            .split(" ")[0];
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Giới tính",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText: "Chọn giới tính",
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
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Nút cập nhật
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String genderCode = "MALE";
                    if (genderController == "NAM") {
                      genderCode = "MALE";
                    } else if (genderController == "NỮ") {
                      genderCode = "FEMALE";
                    }

                    AccountModel accountModel = AccountModel(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        identification: cccdController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        dateOfBirth: dobController.text,
                        genderName: genderController,
                        genderCode: genderCode);

                    profilePageBloc.add(
                        ProfilePageUpdateProfileEvent(account: accountModel));
                  }
                },
                child: const Text("Cập nhật",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
