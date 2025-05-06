import 'package:capstone_pawfund_app/features/data/models/shelter_model.dart';
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
  List<ShelterModel> shelterList = [];

  @override
  void initState() {
    shelterPageBloc.add(ShelterPageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<ShelterPageBloc, ShelterPageState>(
      bloc: shelterPageBloc,
      listenWhen: (previous, current) => current is ShelterPageActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ShelterPageShowShelterDetailPageState:
            final currentState = state as ShelterPageShowShelterDetailPageState;
            Get.to(ShelterDetailPage(
              bloc: shelterPageBloc,
              shelter: currentState.shelterDetail,
            ));

          case ShelterPageShowDonationPageState:
            Get.to(const DonatePage());
        }
      },
      builder: (context, state) {
        if (state is ShelterPageLoadedState) {
          final currentState = state as ShelterPageLoadedState;
          shelterList = currentState.shelterModel;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeader(),
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
                              borderSide:
                                  const BorderSide(color: Colors.orange),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.orange),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // GridView hiển thị danh sách trung tâm
                        // shelterList.isNotEmpty || shelterList.length >= 1
                        //     ?
                        SizedBox(
                          height: size.height * 0.8,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: getCrossAxisCount(context),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              // final shelterItem = shelterList[index];
                              final shelterItem = ShelterModel();
                              return _centerCard(shelterItem, size);
                            },
                          ),
                        )
                        // : const Center(
                        //     child: Column(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         Icon(Icons.info_outline,
                        //             size: 48, color: Colors.grey),
                        //         SizedBox(height: 12),
                        //         Text(
                        //           'Hiện chưa có trung tâm cứu trợ nào được hiển thị.',
                        //           style: TextStyle(
                        //               color: Colors.grey, fontSize: 16),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       ],
                        //     ),
                        //   )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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
            "TRUNG TÂM",
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

  Widget _centerCard(ShelterModel shelter, size) {
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🖼 Banner Image
          Image.asset(
            'assets/images/error_image.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150,
          ),

          // 📍 Location, Title, Rating
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          shelter.shelterName ?? "",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Row(
                        children: [
                          Text('5.0', style: TextStyle(fontSize: 14)),
                          SizedBox(width: 4),
                          Icon(Icons.star, size: 16, color: Colors.black),
                          SizedBox(width: 4),
                          Text('(0)reviews', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          shelter.address ?? "",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 🏷 Tags
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                // Chip đầu tiên
                Chip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.rotate(
                        angle: 40 * 3.1416 / 180,
                        child: const Icon(Icons.pets, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Text('0 Thú cưng'),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  backgroundColor: const Color(0xfff5f5f5),
                  shape: const StadiumBorder(
                    side: BorderSide(
                      color: Color(0xFFCCCCCC),
                      width: 1,
                    ),
                  ),
                ),

                const SizedBox(width: 8), // khoảng cách

                // Container "Chó"
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xffdcdcdc),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text('Chó'),
                ),

                const SizedBox(width: 8), // khoảng cách

                // Container "Mèo"
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xffdcdcdc),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text('Mèo'),
                ),
              ],
            ),
          ),

          // 📞 Call & Website Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.phone),
                  label: Text(shelter.hotline ?? ""),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    foregroundColor: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Website'),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    // TODO: Thực hiện hành động khi bấm
                  },
                  borderRadius:
                      BorderRadius.circular(100), // để hiệu ứng ripple bo tròn
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                    child:
                        const Icon(Icons.favorite_border, color: Colors.orange),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     // TODO: Thực hiện hành động khi bấm
                //   },
                //   borderRadius:
                //       BorderRadius.circular(100), // để hiệu ứng ripple bo tròn
                //   child: Container(
                //     padding: const EdgeInsets.all(8),
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       border: Border.all(color: Colors.orange, width: 2),
                //       color: Colors.orange,
                //     ),
                //     child: const Icon(Icons.favorite, color: Colors.white),
                //   ),
                // ),
              ],
            ),
          ),

          // 🔻 Button Xem thêm
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  shelterPageBloc.add(ShelterPageShowShelterDetailEvent(
                      shelterId: shelter.shelterId!));
                },
                child: const Text('Xem thêm',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
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
      return 3; // iPad ngang hoặc màn lớn
    } else if (screenWidth >= 600) {
      return 2; // iPad đứng hoặc tablet nhỏ
    } else {
      return 1; // điện thoại
    }
  }
}
