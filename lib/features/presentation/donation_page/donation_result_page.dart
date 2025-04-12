import 'package:capstone_pawfund_app/features/presentation/donation_page/bloc/donation_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationResultPage extends StatefulWidget {
  DonationPageBloc bloc;
  DonationResultPage({
    super.key,
    required this.bloc,
  });

  @override
  State<DonationResultPage> createState() => _DonationResultPageState();
  static const String DonationResultPageRoute = "/donation_result_page";
}

class _DonationResultPageState extends State<DonationResultPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const Color mainOrangeColor = Color(0xFFF36439);
    return PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {}
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 1) header
                  _buildHeader(size),
                  const SizedBox(height: 20),

                  // 2) Phần nội dung bên dưới
                  _buildBody(size, mainOrangeColor),
                ],
              ),
            ),
          ),
        ));
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
                "Hóa đơn".toUpperCase(),
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

  Widget _buildBody(Size size, Color mainOrangeColor) {
    return Container(
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
                'Animal Adoption Foundation xin chân thành cảm ơn những đóng góp quý báu của bạn.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: mainOrangeColor,
                ),
              ),

              const SizedBox(height: 20),

              //
              _TransactionSuccess(size, mainOrangeColor),
              const SizedBox(height: 20),

              //  Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF36439),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "xác nhận".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _TransactionSuccess(Size size, Color mainOrangeColor) {
    return Center(
      child: Stack(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 129, 129, 129),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                const Text(
                  'Giao dịch thành công',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '100.000 VNĐ',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                    "Tên chiến dịch:", "Cocoon x AAF gây quỹ cứu trợ chó mèo"),
                _buildInfoRow("Người nhận:", "ANIMAL ADOPTION FOUNDATION"),
                _buildInfoRow("Tài khoản nhận:", "123456789"),
                _buildInfoRow("Người chuyển:", "Nguyen Phuong Quang"),
                _buildInfoRow("Số tiền:", "100.000 VNĐ"),
                _buildInfoRow("Ngày chuyển:", "22/02/2025"),
                _buildInfoRow("Nội dung:", "Nguyen Phuong Quang DGUH\nCDGQ001"),
              ],
            ),
          ),
          Positioned(
            top: -25,
            left: -size.width * 0.5,
            right: -size.width * 0.5,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/check.png', // ✅ Đảm bảo ảnh có trong pubspec.yaml
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        padding: const EdgeInsets.only(bottom: 4),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE5E5E5),
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
