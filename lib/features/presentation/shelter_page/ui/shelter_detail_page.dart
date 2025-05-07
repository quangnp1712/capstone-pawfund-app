// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:capstone_pawfund_app/features/data/models/shelter_model.dart';
import 'package:capstone_pawfund_app/features/presentation/shelter_page/bloc/shelter_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/landing_navigation_bottom/landing_navigation_bottom.dart';
import 'package:intl/intl.dart';

class ShelterDetailPage extends StatefulWidget {
  final ShelterPageBloc bloc;
  final ShelterModel shelter;
  const ShelterDetailPage({
    super.key,
    required this.bloc,
    required this.shelter,
  });

  @override
  State<ShelterDetailPage> createState() => _ShelterDetailPageState();

  static const String ShelterDetailPageRoute = "/shelter_detail";
}

class _ShelterDetailPageState extends State<ShelterDetailPage> {
  @override
  Widget build(BuildContext context) {
    const Color mainOrangeColor = Color(0xFFF36439);
    final size = MediaQuery.of(context).size;
    const double bannerHeight = 350;
    final isWideScreen = size.width >= 600;
    final String yearsOfOperation = (DateTime.now().year -
            DateTime.parse(widget.shelter.dateOfPub.toString()).year)
        .toString();
    final String _dateOfPub = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(widget.shelter.dateOfPub.toString()))
        .toString();

    final List<Widget> cards = [
      buildInfoCard(
        title: 'Năm thành lập',
        value: "${DateTime.parse(widget.shelter.dateOfPub.toString()).year}",
        subtitle: '$yearsOfOperation năm hoạt động',
        isWideScreen: isWideScreen,
      ),
      buildInfoCard(
        title: 'Nhân viên và tình nguyện viên',
        value: '41',
        subtitle: '11 nhân viên, 30 tình nguyện viên',
        isWideScreen: isWideScreen,
      ),
      buildInfoCard(
        title: 'Có thể nhận nuôi',
        value: '54',
        subtitle: '24 chó, 30 mèo, ...vv',
        isWideScreen: isWideScreen,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // 1) header
                  _buildHeader(size, bannerHeight),

                  // 2) Phần nội dung bên dưới
                  _buildBody(size, bannerHeight, mainOrangeColor, isWideScreen,
                      cards, _dateOfPub),
                ],
              ),
            ),
            _DonateButton(size),
            const SizedBox(height: 20),
          ],
        ),
      ),
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

  Widget _buildHeader(Size size, double bannerHeight) {
    return Stack(
      children: [
        // ảnh
        Container(
          height: bannerHeight,
          width: size.width,
          color: Colors.orange.shade200, // màu cam nhạt
          child: Image.asset(
            'assets/images/error_image.png', // Đặt ảnh bạn muốn
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          ),
        ),

        // border
        Positioned(
            // Vị trí bắt đầu so với top
            top: bannerHeight - 30,
            // Dịch lên khoảng 50 để body chồng lên banner
            left: 0,
            right: 0,
            child: Container(
                // Chiều cao còn lại, tùy chỉnh hoặc để auto
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ))),

        // icon back
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 50,
            child: IconButton(
              color: Colors.transparent,
              alignment: Alignment.center,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBody(Size size, double bannerHeight, Color mainOrangeColor,
      isWideScreen, cards, String _dateOfPub) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: size.height - bannerHeight),
      child: Container(
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  widget.shelter.shelterName ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                _LogoShelter(mainOrangeColor),
                const SizedBox(height: 20),
                Text(widget.shelter.description ?? "",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.justify),
                const SizedBox(height: 30),
                isWideScreen
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: cards
                            .map<Widget>((card) => Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: card,
                                ))
                            .toList())
                    : Column(
                        children: cards
                            .map((card) => Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: card,
                                ))
                            .toList(),
                      ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Thông tin chi tiết",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: mainOrangeColor)),
                  ],
                ),
                const SizedBox(height: 8),
                _shelterInfor(mainOrangeColor, widget.shelter, _dateOfPub),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Khung giờ mở cửa",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: mainOrangeColor)),
                  ],
                ),
                const SizedBox(height: 8),
                _shelterOpen(mainOrangeColor, widget.shelter),
                const SizedBox(height: 30),
                _sectionTitle(
                  "Nhận nuôi thú cưng",
                  mainOrangeColor,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => _petAdoptCard(),
                  ),
                ),
                const SizedBox(height: 30),
                _sectionTitle("Chiến dịch gây quỹ", mainOrangeColor),
                const SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => _rescueCenterCard(size),
                  ),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _LogoShelter(Color mainOrangeColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // căn thông tin top
      children: [
        // Vùng logo tròn
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.orange, // Màu viền cam
              width: 2,
            ),
          ),
          // Logo hoặc icon ở giữa
          child: Center(
            // Giả sử bạn có ảnh tại assets/images/dog_shield.png
            child: Image.asset(
              'assets/images/Logo_chua_xoa_nen.png',
              width: 28,
              height: 28,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 10), // khoảng cách giữa logo và thông tin
        // Phần thông tin địa chỉ + điện thoại
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dòng địa chỉ
              const SizedBox(width: 4),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: mainOrangeColor,
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      '1 Quang Trung, p.1, Q.Gò Vấp (50m)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),

              // Dòng số điện thoại
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 18,
                    color: mainOrangeColor,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '0900 100 100',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              // email
              const SizedBox(width: 5),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 18,
                    color: mainOrangeColor,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'quangnpse130190@gmail.com',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title, Color mainOrangeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: mainOrangeColor)),
        TextButton(
            onPressed: () {},
            child: const Text("Xem thêm",
                style: TextStyle(color: Color(0xFFF36439)))),
      ],
    );
  }

  Widget _shelterInfor(
      Color mainOrangeColor, ShelterModel shelter, String _dateOfPub) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // tên trung tâm
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    "Tên trung tâm:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    shelter.shelterName ?? "",
                    style: TextStyle(
                        color: mainOrangeColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // ngày thành lập
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    "Ngày thành lập:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    _dateOfPub,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // email
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    "Email:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    shelter.email ?? "",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // hotline
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    "Hotline:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    shelter.hotline ?? "",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // địa chỉ
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    "Địa chỉ:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    shelter.address ?? "",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shelterOpen(Color mainOrangeColor, ShelterModel shelter) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Thứ 2 - Thứ 6
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Thứ 2 - Thứ 6:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    "9:00 sáng - 7:00 tối",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w900),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Thứ 7 - Chủ Nhật:
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Thứ 7 - Chủ Nhật: :",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    "9:00 sáng - 4:00 chiều",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
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
              'assets/images/error_image.png',
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
              'assets/images/error_image.png',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Cocoon x AAF gây quỹ cho trạm cứu trợ chó mèo",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _DonateButton(Size size) {
    return Positioned(
      bottom: 12.0,
      left: 20.0,
      right: 20.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          child: ElevatedButton(
            onPressed: () async {
              widget.bloc.add(ShelterPageShowDonationPageEvent());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF36439),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bo góc
                side: const BorderSide(
                    color: Colors.deepOrange, width: 2), // Viền
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            ),
            child: Text(
              "ủng hộ".toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard({
    required String title,
    required String value,
    required String subtitle,
    required bool isWideScreen,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: isWideScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
    );
  }
}
