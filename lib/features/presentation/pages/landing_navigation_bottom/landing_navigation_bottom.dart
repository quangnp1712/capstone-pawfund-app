// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:capstone_pawfund_app/features/presentation/adoption_page/adoption_page.dart';
import 'package:capstone_pawfund_app/features/presentation/funding_page/funding_page.dart';
import 'package:capstone_pawfund_app/features/presentation/home_page/home_page.dart';
import 'package:capstone_pawfund_app/features/presentation/pages/landing_navigation_bottom/bloc/landing_navigation_bottom_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/profile_page/profile_page.dart';
import 'package:capstone_pawfund_app/features/presentation/shelter_page/shelter_page.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class LandingPage extends StatefulWidget {
  final int? index;
  const LandingPage({
    super.key,
    this.index,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
  static const LandingPageRoute = '/pawfund';
}

class _LandingPageState extends State<LandingPage> {
  final LandingNavigationBottomBloc landingBloc = LandingNavigationBottomBloc();
  late String token;

  int bottomIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  late final HomePage homePage;
  late final ShelterPage shelterPage;
  late final AdoptionPage adoptionPage;
  late final FundingPage fundingPage;
  late final ProfilePage profilePage;

  void setPage(index) {
    final CurvedNavigationBarState? navBarState =
        _bottomNavigationKey.currentState;
    navBarState?.setPage(index);
  }

  @override
  void initState() {
    // Lấy token từ arguments
    final arguments = Get.arguments as Map<String, dynamic>?;
    token = arguments?.isNull ?? true ? "" : arguments?['token'];
    // landingPageBloc.add(LandingPageInitial(bottomIndex: 0) as LandingPageEvent);
    // print('Current Route: ${Get.currentRoute}');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.index != null) {
        bottomIndex = widget.index!;
        setPage(bottomIndex);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(setPage),
      ShelterPage(setPage),
      AdoptionPage(setPage),
      FundingPage(setPage),
      ProfilePage(setPage),
    ];
    return BlocConsumer<LandingNavigationBottomBloc,
            LandingNavigationBottomInitial>(
        bloc: landingBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              // key: _bottomNavigationKey,
              body: pages[state.bottomIndex],
              bottomNavigationBar: CurvedNavigationBar(
                key: _bottomNavigationKey,
                color: Colors.white,
                backgroundColor: Colors.black87,
                items: const [
                  CurvedNavigationBarItem(
                    child: Icon(Icons.home_outlined),
                    label: 'Trang chủ',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.list_alt),
                    label: 'Nhận nuôi',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.calendar_month),
                    label: 'Trung tâm',
                  ),
                  CurvedNavigationBarItem(
                    // child: Icon(Icons.newspaper),
                    child: Icon(CommunityMaterialIcons.ticket_percent_outline),
                    label: 'Ủng hộ',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.perm_identity),
                    label: 'Tài khoản',
                  ),
                ],
                onTap: (index) {
                  landingBloc.add(LandingNavigationBottomTabChangeEvent(
                      bottomIndex: index));
                },
              ),
            ),
          );
        });
  }
}
