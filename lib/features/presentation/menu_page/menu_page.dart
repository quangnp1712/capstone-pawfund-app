import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/authentication_page.dart';
import 'package:capstone_pawfund_app/features/presentation/change_email_page/change_email_page.dart';
import 'package:capstone_pawfund_app/features/presentation/change_pass_page/change_pass_page.dart';
import 'package:capstone_pawfund_app/features/presentation/menu_page/bloc/menu_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/profile_page/profile_page.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MenuPage extends StatefulWidget {
  final Function callback;
  const MenuPage(
    this.callback, {
    super.key,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();

  static const String MenuPageRoute = "/menu";
}

class _MenuPageState extends State<MenuPage> {
  final MenuPageBloc menuPageBloc = MenuPageBloc();

  @override
  void initState() {
    menuPageBloc.add(MenuPageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isLogin = false;
    String avatar = "";
    String name = "";
    String phone = "";
    String email = "";

    return BlocConsumer<MenuPageBloc, MenuPageState>(
      bloc: menuPageBloc,
      listenWhen: (previous, current) => current is MenuPageActionState,
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
        if (state is IsLoginState) {
          isLogin = state.isLogin;
        }
        if (state is MenuPageLoadedState) {
          avatar = state.account.avatarUrl ?? "";
          name = state.account.name ?? "";
          phone = state.account.phone ?? "";
          email = state.account.email ?? "";
          isLogin = state.isLogin;
        }
        return Scaffold(
          body: SafeArea(
            child: PopScope(
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  widget.callback(0);
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    state is MenuPageLoadingPageState
                        ? _buildLoadingPage()
                        : Column(
                            children: [
                              isLogin
                                  ? Column(
                                      children: [
                                        _buildProfileInfo(
                                            size, avatar, name, phone, email),
                                        const SizedBox(height: 20),
                                        _buildMenuSection("Cá nhân", [
                                          _buildMenuItem(
                                              Icons.verified,
                                              "Xem và Chỉnh sửa thông tin",
                                              ProfilePage.ProfilePageRoute),
                                          _buildMenuItem(
                                              Icons.email,
                                              "Đổi email",
                                              ChangeEmailPage
                                                  .ChangeEmailPageRoute),
                                          _buildMenuItem(
                                              Icons.lock,
                                              "Đổi mật khẩu",
                                              ChangePassPage
                                                  .ChangePassPageRoute),
                                          _buildMenuItem(Icons.pets,
                                              "Thú cưng đã nhận nuôi", ""),
                                          _buildMenuItem(Icons.history,
                                              "Lịch sử quyên góp", ""),
                                          _buildMenuItem(Icons.favorite,
                                              "Thú cưng yêu thích", ""),
                                          _buildMenuItem(Icons.article,
                                              "Lịch sử hoạt động", ""),
                                        ]),
                                      ],
                                    )
                                  : _buildLoginButton(size),
                              _buildMenuSection("Hệ thống", [
                                _buildMenuItem(Icons.location_on,
                                    "Trung tâm cứu trợ gần đây", ""),
                                _buildMenuItem(
                                    Icons.message, "Hộp thư phản hồi", ""),
                                _buildMenuItem(
                                    Icons.settings, "Cài đặt & Bảo mật", ""),
                              ]),
                              isLogin
                                  ? _buildMenuItem(
                                      Icons.logout, "Đăng xuất", "",
                                      isLogout: true)
                                  : Container(),
                            ],
                          ),
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

  Widget _buildHeader() {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo_1.png',
                height: 40,
              ),
            ],
          ),
          const Center(
              child: Text(
            "MENU",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 30,
              weight: 0.1,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(Size size, avatar, name, phone, email) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CircleAvatar(
              child: ClipOval(
                child: avatar != null
                    ? CachedNetworkImage(
                        imageUrl: avatar!,
                        // placeholder: (context, url) =>
                        //     const CircularProgressIndicator(),
                        fit: BoxFit.cover,
                        // width: 120,
                        // height: 120,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
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
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.phone, color: Color(0xFFF36439), size: 20),
                    const SizedBox(width: 4),
                    Text(
                      phone,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: Color(0xFFF36439),
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      email,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(Size size) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
          height: 200,
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                await Get.toNamed(AuthenticationPage.AuthenticationPageRoute);
                menuPageBloc.add(MenuPageInitialEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF36439),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bo góc
                  side: const BorderSide(
                      color: Colors.deepOrange, width: 2), // Viền
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              ),
              child: const Text(
                "Đăng nhập",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(children: items),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, String route,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: isLogout ? Colors.red : Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: isLogout
          ? null
          : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        isLogout ? menuPageBloc.add(MenuPageLogoutEvent()) : Get.toNamed(route);
      },
    );
  }
}
