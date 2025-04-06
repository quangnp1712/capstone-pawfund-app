import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone_pawfund_app/features/presentation/change_pass_page/bloc/change_pass_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/dialog/loading_dialog.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();

  static const String ChangePassPageRoute = "/change_pass";
}

class _ChangePassPageState extends State<ChangePassPage> {
  final ChangePassPageBloc changePassPageBloc = ChangePassPageBloc();
  CloseDialog? _closeDialogHandle;
  ShowDialog? _showDialogHandle;

  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? avatarUrl;

  @override
  void initState() {
    changePassPageBloc.add(ChangePassPageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool _obscureTextOldPasswword = true;
    bool _obscureTextNewPasswword = true;
    bool _obscureTextComfirmPasswword = true;

    return BlocConsumer<ChangePassPageBloc, ChangePassPageState>(
      bloc: changePassPageBloc,
      listenWhen: (previous, current) => current is ChangePassPageActionState,
      buildWhen: (previous, current) => current is! ChangePassPageActionState,
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
          case ChangePassPageLoadingState:
            final currentState = state as ChangePassPageLoadingState;
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
                    const SizedBox(height: 10),
                    _buildBody(size, _obscureTextOldPasswword,
                        _obscureTextNewPasswword, _obscureTextComfirmPasswword),
                  ],
                ),
              ),
            ),
          ),
        );
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
                "Đổi mật khẩu".toUpperCase(),
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

  Widget _buildBody(Size size, _obscureTextOldPasswword,
      _obscureTextNewPasswword, _obscureTextComfirmPasswword) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
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
                    "Nhập mật khẩu hiện tại",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: oldPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: _obscureTextOldPasswword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText: "Nhập mật khẩu hiện tại",
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextOldPasswword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          _obscureTextOldPasswword = !_obscureTextOldPasswword;
                        },
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu ';
                      }
                      return null; // Trả về null nếu không có lỗi
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
                    "Nhập mật khẩu mới",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: newPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: _obscureTextNewPasswword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText: "Nhập mật khẩu mới",
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextNewPasswword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          _obscureTextNewPasswword = !_obscureTextNewPasswword;
                        },
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu mới';
                      }
                      return null; // Trả về null nếu không có lỗi
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
                    "Nhập lại mật khẩu mới",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36439)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: _obscureTextComfirmPasswword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintText: "Nhập lại mật khẩu mới",
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextComfirmPasswword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          _obscureTextComfirmPasswword =
                              !_obscureTextComfirmPasswword;
                        },
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập lại mật khẩu mới';
                      }
                      if (value != newPasswordController.text) {
                        return 'Mật khẩu không khớp';
                      }
                      return null; // Trả về null nếu không có lỗi
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
                    changePassPageBloc.add(ChangePassPageSubmitEvent(
                        oldPassword: oldPasswordController.text,
                        newPassword: newPasswordController.text));
                  }
                },
                child: const Text("Đổi mật khẩu",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
