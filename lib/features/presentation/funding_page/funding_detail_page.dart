import 'package:capstone_pawfund_app/features/presentation/funding_page/bloc/funding_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FundingDetailPage extends StatefulWidget {
  final FundingPageBloc bloc;
  const FundingDetailPage({super.key, required this.bloc});
  @override
  State<FundingDetailPage> createState() => _FundingDetailPageState();

  static const String FundingDetailPageRoute = "/Funding_detail";
}

class _FundingDetailPageState extends State<FundingDetailPage> {
  final String textFunding =
      "Đối với nhiều người trong chúng ta, chó mèo giống như những \"người bạn\", \"người thân trong gia đình\", tuy nhiên, không phải chó mèo cũng may mắn có được cuộc sống đầm ấm bên các \"sen\". Theo báo cáo từ Cục Thú Y Việt Nam, mỗi năm tại nước ta, có hơn 5 triệu chó mèo bị sát hại để phục vụ cho việc buôn bán. Đó là những em chó mèo bị bỏ rơi, sống lang thang, đi lạc hoặc bị bắt cóc. Trước thực trạng ấy, nhiều cá nhân, tổ chức đã đứng ra thành lập các trạm cứu hộ chó mèo, điều này không chỉ góp phần ngăn chặn nạn mua bán chó mèo tại Việt Nam mà còn mang lại cuộc sống tốt đẹp hơn cho rất nhiều chó mèo kém may mắn.";

  @override
  Widget build(BuildContext context) {
    const Color mainOrangeColor = Color(0xFFF36439);
    final size = MediaQuery.of(context).size;
    const double bannerHeight = 350;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // 1) header
                  _buildHeader(size, bannerHeight, mainOrangeColor),

                  // 2) Phần nội dung bên dưới
                  _buildBody(size, bannerHeight, mainOrangeColor, textFunding),
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

  Widget _buildHeader(Size size, double bannerHeight, Color mainOrangeColor) {
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
              color: mainOrangeColor,
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
      String textFunding) {
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
                const Text(
                  'Cocoon x AAF gây quỹ cứu trợ chó mèo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                _LogoFunding(mainOrangeColor),
                const SizedBox(height: 20),
                const Text(
                  "Khẳng định sự nghiêm túc đối với hành trình bảo vệ động vật tại Việt Nam, mỹ phẩm thuần chay Cocoon đã tiếp tục bắt tay cùng Tổ chức Động vật Châu Á (AAF) để thực hiện chiến dịch \"chung tay cứu trợ chó mèo lang thang\".",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Cocoon x AAF khởi xướng chiến dịch gây quỹ \"chung tay cứu trợ chó mèo lang thang\"",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                Text(
                  textFunding,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    'assets/images/error_image.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
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

  Widget _LogoFunding(Color mainOrangeColor) {
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
              widget.bloc.add(FundingPageShowDonationPageEvent());
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
}
