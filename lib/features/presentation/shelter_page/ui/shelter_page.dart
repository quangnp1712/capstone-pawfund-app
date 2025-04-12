import 'package:capstone_pawfund_app/features/presentation/donation_page/donation_page.dart';
import 'package:capstone_pawfund_app/features/presentation/shelter_page/bloc/shelter_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/shelter_page/ui/shelter_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ShelterPage extends StatefulWidget {
  final Function callback;
  const ShelterPage(
    this.callback, {
    super.key,
  });

  @override
  State<ShelterPage> createState() => _ShelterPageState();

  static const String ShelterPageRoute = "/shelter-page";
}

class _ShelterPageState extends State<ShelterPage> {
  ShelterPageBloc shelterPageBloc = ShelterPageBloc();

  @override
  void initState() {
    shelterPageBloc.add(ShelterPageInitialEvent());
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
    return BlocConsumer<ShelterPageBloc, ShelterPageState>(
      bloc: shelterPageBloc,
      listenWhen: (previous, current) => current is ShelterPageActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ShelterPageShowShelterDetailPageState:
            Get.to(ShelterDetailPage(bloc: shelterPageBloc));

          case ShelterPageShowDonationPageState:
            Get.to(const DonatePage());
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: SingleChildScrollView(
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: getCrossAxisCount(context),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: rescueCenters.length,
                        itemBuilder: (context, index) {
                          final center = rescueCenters[index];
                          return _centerCard(
                              center["image"]!, center["name"]!, size);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      },
    );
  }

  Widget _centerCard(String imageUrl, String name, size) {
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
              height: 250,
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
              onPressed: () {
                shelterPageBloc.add(ShelterPageShowShelterDetailEvent());
              },
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

  int getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 900) {
      return 4; // iPad ngang hoặc màn lớn
    } else if (screenWidth >= 600) {
      return 3; // iPad đứng hoặc tablet nhỏ
    } else {
      return 2; // điện thoại
    }
  }
}
