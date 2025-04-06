import 'bloc/home_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/authentication_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final Function callback;
  const HomePage(
    this.callback, {
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();

  static const String HomePageRoute = "/home";
}

class _HomePageState extends State<HomePage> {
  HomePageBloc homePageBloc = HomePageBloc();

  @override
  void initState() {
    homePageBloc.add(HomePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<HomePageBloc, HomePageState>(
        bloc: homePageBloc,
        listenWhen: (previous, current) => current is HomePageActionState,
        listener: (context, state) {
          switch (state.runtimeType) {
            case ShowLoginPageState:
              Get.toNamed(AuthenticationPage.AuthenticationPageRoute);
              break;
          }
        },
        builder: (context, state) {
          bool isLogin = false;
          if (state is IsLoginState) {
            isLogin = state.isLogin;
          }
          return _buildBody(size, isLogin);
        });
  }

  Widget _buildBody(Size size, bool isLogin) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(isLogin),
              const SizedBox(height: 20),
              _sectionTitle("Loại thú cưng nhận nuôi"),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => _categoryCard(),
                ),
              ),
              const SizedBox(height: 20),
              _sectionTitle("Nhận nuôi thú cưng"),
              const SizedBox(height: 10),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => _petAdoptCard(),
                ),
              ),
              const SizedBox(height: 20),
              _sosBanner(size),
              const SizedBox(height: 20),
              _sectionTitle("Quỹ hỗ trợ"),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => _supportFundCard(size),
                ),
              ),
              const SizedBox(height: 20),
              _sectionTitle("Trung tâm cứu trợ"),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => _rescueCenterCard(size),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLogin) {
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
          isLogin
              ? IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 30,
                    weight: 0.1,
                  ),
                  onPressed: () {},
                )
              : ElevatedButton(
                  onPressed: () async {
                    await Get.toNamed(
                        AuthenticationPage.AuthenticationPageRoute);
                    homePageBloc.add(HomePageInitialEvent());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Màu nền
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
                      color: Colors.deepOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )

          // IconButton(
          //   icon: const Icon(
          //     Icons.notifications_none,
          //     color: Colors.white,
          //     size: 30,
          //     weight: 0.1,
          //   ),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextButton(
              onPressed: () {},
              child: const Text("Xem thêm",
                  style: TextStyle(color: Color(0xFFF36439)))),
        ],
      ),
    );
  }

  Widget _categoryCard() {
    return GestureDetector(
        onTap: () {},
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/shield.png'),
                        fit: BoxFit.cover)),
                child: const Icon(Icons.pets, size: 40),
              ),
              const SizedBox(height: 8),
              const Text(
                "Mèo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ]));
  }

  Widget _petAdoptCard() {
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrangeAccent),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/pet.png',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Nguyễn Tiến Dũng",
            style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Chiều cao:",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Text(
                  "22cm",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Tuổi:",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  "4 tuổi",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            "200.000 vnđ",
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.male, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.deepOrangeAccent),
                ),
                child: const Icon(Icons.favorite_outline,
                    color: Colors.deepOrangeAccent, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sosBanner(Size size) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFFFA726)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo_2.png',
            height: size.height * 0.1,
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      color: Colors.white, size: 18),
                  SizedBox(width: 4),
                  Text(
                    "1 Quang Trung, p.1, Q.Gò Vấp",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone_outlined, color: Colors.white, size: 18),
                  SizedBox(width: 4),
                  Text("0900 100 100",
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: size.width * 0.3,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "CỨU HỘ NGAY >>",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _supportFundCard(Size size) {
    return Container(
      width: size.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF36439),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              'assets/images/support_fund.png',
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Cocoon x AAF gây quỹ cho trạm cứu trợ chó mèo",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFF36439),
                minimumSize: const Size(double.infinity, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "ỦNG HỘ NGAY",
                style: TextStyle(
                    color: Color(0xFFF36439),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rescueCenterCard(Size size) {
    return Container(
      width: size.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrangeAccent),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/pet.png',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Cocoon x AAF gây quỹ cho trạm cứu trợ chó mèo",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF36439),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "XEM THÊM",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
