import 'package:capstone_pawfund_app/features/presentation/funding_page/bloc/funding_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundingPage extends StatefulWidget {
  final Function callback;
  const FundingPage(
    this.callback, {
    super.key,
  });

  @override
  State<FundingPage> createState() => _FundingPageState();

  static const String FundingPageRoute = "/funding-page";
}

class _FundingPageState extends State<FundingPage> {
  FundingPageBloc fundingPageBloc = FundingPageBloc();

  @override
  void initState() {
    fundingPageBloc.add(FundingPageInitialEvent());
    super.initState();
  }

  final List<Map<String, String>> rescueCenters = [
    {
      "image": 'assets/images/error_image.png',
      "name": "Animal Adoption Foundation"
    },
    {
      "image": 'assets/images/error_image.png',
      "name": "PAWFUND ADOPTION CENTER"
    },
    {
      "image": "assets/images/error_image.png",
      "name": "Animal Adoption Foundation"
    },
    {
      "image": "assets/images/error_image.png",
      "name": "PAWFUND ADOPTION CENTER"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double progressValue = 0.05;

    return BlocConsumer<FundingPageBloc, FundingPageState>(
      bloc: fundingPageBloc,
      listenWhen: (previous, current) => current is FundingPageActionState,
      listener: (context, state) {
        switch (state.runtimeType) {}
      },
      builder: (context, state) {
        return Scaffold(
            body: PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              widget.callback(0);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
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
                        "TRUNG TÂM",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Ô tìm kiếm
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Tìm kiếm trung tâm cứu hộ",
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.orange),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // GridView hiển thị danh sách trung tâm
                      SizedBox(
                        height: size.height * 0.8,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: getCrossAxisCount(context),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: rescueCenters.length,
                          itemBuilder: (context, index) {
                            final center = rescueCenters[index];
                            return _centerCard(center["image"]!,
                                center["name"]!, size, progressValue);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  Widget _centerCard(String imageUrl, String name, size, double progressValue) {
    return Container(
      width: size.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrangeAccent),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼 Banner Image
          Padding(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                'assets/images/error_image.png',
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // title
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(
              'Cocoon x AAF gây quỹ cho trạm cứu trợ chó mèo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // description
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(
              'Cocoon x AAF khởi xướng chiến dịch gây quỹ "chung tay cứu trợ chó mèo lang thang"',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // deadline
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Còn 15 ngày',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Thanh tiến trình
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: Colors.transparent,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFFF45A32)),
                  ),
                ),
              )),
          const SizedBox(height: 12),

          // số tiền đã góp
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Đã quyên góp được: ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: '1.000.000 / 20.000.000 vnđ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' (5%)',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Nút ủng hộ
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFF45A32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'ỦNG HỘ NGAY',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  int getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 900) {
      return 2; // iPad ngang hoặc màn lớn
    } else if (screenWidth >= 600) {
      return 2; // iPad đứng hoặc tablet nhỏ
    } else {
      return 1; // điện thoại
    }
  }
}
