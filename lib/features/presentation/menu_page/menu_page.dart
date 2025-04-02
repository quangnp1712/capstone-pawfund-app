import 'package:capstone_pawfund_app/features/presentation/authentication/ui/authentication_page.dart';
import 'package:capstone_pawfund_app/features/presentation/menu_page/bloc/menu_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/profile_page/profile_page.dart';
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

    return BlocConsumer<MenuPageBloc, MenuPageState>(
      bloc: menuPageBloc,
      listenWhen: (previous, current) => current is MenuPageActionState,
      listener: (context, state) {},
      builder: (context, state) {
        bool isLogin = false;
        if (state is IsLoginState) {
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
                    isLogin
                        ? Column(
                            children: [
                              _buildProfileInfo(size),
                              const SizedBox(height: 20),
                              _buildMenuSection("Cá nhân", [
                                _buildMenuItem(
                                    Icons.verified,
                                    "Xem và Chỉnh sửa thông tin",
                                    ProfilePage.ProfilePageRoute),
                                _buildMenuItem(Icons.email, "Đổi email", ""),
                                _buildMenuItem(Icons.lock, "Đổi mật khẩu", ""),
                                _buildMenuItem(
                                    Icons.pets, "Thú cưng đã nhận nuôi", ""),
                                _buildMenuItem(
                                    Icons.history, "Lịch sử quyên góp", ""),
                                _buildMenuItem(
                                    Icons.favorite, "Thú cưng yêu thích", ""),
                              ]),
                            ],
                          )
                        : _buildLoginButton(size),
                    _buildMenuSection("Hệ thống", [
                      _buildMenuItem(
                          Icons.location_on, "Trung tâm cứu trợ gần đây", ""),
                      _buildMenuItem(Icons.message, "Hộp thư phản hồi", ""),
                      _buildMenuItem(Icons.settings, "Cài đặt & Bảo mật", ""),
                    ]),
                    _buildMenuItem(Icons.logout, "Đăng xuất", "",
                        isLogout: true),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

  Widget _buildProfileInfo(Size size) {
    return const Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          SizedBox(height: 10),
          Text(
            'Nguyễn Phương Quang',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: 340,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "090999999",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                Text(
                  "090999999",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
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
              onPressed: () {
                Get.toNamed(AuthenticationPage.AuthenticationPageRoute);
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
        Get.toNamed(route);
      },
    );
  }
}
