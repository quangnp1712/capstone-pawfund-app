import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  final Function callback;
  const MenuPage(
    this.callback, {
    super.key,
  });

  @override
  State<MenuPage> createState() => _ProfilePageState();

  static const String ProfilePageRoute = "/menu";
}

class _ProfilePageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildProfileInfo(size),
              const SizedBox(height: 20),
              _buildMenuSection("Cá nhân", [
                _buildMenuItem(Icons.verified, "Xem và Chỉnh sửa thông tin"),
                _buildMenuItem(Icons.email, "Đổi email"),
                _buildMenuItem(Icons.lock, "Đổi mật khẩu"),
                _buildMenuItem(Icons.pets, "Thú cưng đã nhận nuôi"),
                _buildMenuItem(Icons.history, "Lịch sử quyên góp"),
                _buildMenuItem(Icons.favorite, "Thú cưng yêu thích"),
              ]),
              _buildMenuSection("Hệ thống", [
                _buildMenuItem(Icons.location_on, "Trung tâm cứu trợ gần đây"),
                _buildMenuItem(Icons.message, "Hộp thư phản hồi"),
                _buildMenuItem(Icons.settings, "Cài đặt & Bảo mật"),
              ]),
              _buildMenuItem(Icons.logout, "Đăng xuất", isLogout: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
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
          Center(
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
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        const SizedBox(height: 10),
        Text(
          'Nguyễn Phương Quang',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "090999999",
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ],
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

  Widget _buildMenuItem(IconData icon, String text, {bool isLogout = false}) {
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
      onTap: () {},
    );
  }
}
