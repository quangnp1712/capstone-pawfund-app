import 'package:capstone_pawfund_app/features/data/models/shelter_model.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/authentication_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/login_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/register_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/verifiction_email_page.dart';
import 'package:capstone_pawfund_app/features/presentation/change_email_page/bloc/change_email_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/change_email_page/change_email_page.dart';
import 'package:capstone_pawfund_app/features/presentation/change_pass_page/bloc/change_pass_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/change_pass_page/change_pass_page.dart';
import 'package:capstone_pawfund_app/features/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/home_page/home_page.dart';
import 'package:capstone_pawfund_app/features/presentation/menu_page/bloc/menu_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/menu_page/menu_page.dart';
import 'package:capstone_pawfund_app/features/presentation/profile_page/bloc/profile_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/profile_page/profile_page.dart';
import 'package:capstone_pawfund_app/features/presentation/shelter_page/bloc/shelter_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/shelter_page/ui/shelter_detail_page.dart';
import 'package:capstone_pawfund_app/features/presentation/shelter_page/ui/shelter_page.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/landing_navigation_bottom/bloc/landing_navigation_bottom_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../features/presentation/widgets/landing_navigation_bottom/landing_navigation_bottom.dart';
import '../../features/presentation/pages/splash_page.dart';

class RouteGenerator {
  final LandingNavigationBottomBloc landingNavigationBottomBloc =
      LandingNavigationBottomBloc();
  final AuthenticationBloc authenticationBloc = AuthenticationBloc();
  final HomePageBloc homePageBloc = HomePageBloc();
  final MenuPageBloc menuPageBloc = MenuPageBloc();
  final ProfilePageBloc profilePageBloc = ProfilePageBloc();
  final ChangePassPageBloc changePassPageBloc = ChangePassPageBloc();
  final ChangeEmailPageBloc changeEmailPageBloc = ChangeEmailPageBloc();
  final ShelterPageBloc shelterPageBloc = ShelterPageBloc();

  List<GetPage> routes() {
    return [
      GetPage(
        name: SplashPage.SplashPageRoute,
        page: () => const SplashPage(),
      ),
      GetPage(
        name: LandingNavBottomWidget.LandingNavBottomWidgetRoute,
        page: () => BlocProvider<LandingNavigationBottomBloc>.value(
            value: landingNavigationBottomBloc,
            child: const LandingNavBottomWidget()),
      ),
      GetPage(
        name: AuthenticationPage.AuthenticationPageRoute,
        page: () => BlocProvider<AuthenticationBloc>.value(
            value: authenticationBloc, child: AuthenticationPage()),
      ),
      GetPage(
        name: ProfilePage.ProfilePageRoute,
        page: () => BlocProvider<ProfilePageBloc>.value(
            value: profilePageBloc, child: const ProfilePage()),
      ),
      GetPage(
        name: ChangePassPage.ChangePassPageRoute,
        page: () => BlocProvider<ChangePassPageBloc>.value(
            value: changePassPageBloc, child: const ChangePassPage()),
      ),
      GetPage(
        name: ChangeEmailPage.ChangeEmailPageRoute,
        page: () => BlocProvider<ChangeEmailPageBloc>.value(
            value: changeEmailPageBloc, child: const ChangeEmailPage()),
      ),
      GetPage(
        name: ShelterPage.ShelterPageRoute,
        page: () {
          callback(int index) {} // Hàm callback rỗng hoặc hàm cụ thể của bạn
          return BlocProvider<ShelterPageBloc>.value(
              value: shelterPageBloc, child: ShelterPage(callback));
        },
      ),
      GetPage(
        name: HomePage.HomePageRoute,
        page: () {
          callback(int index) {} // Hàm callback rỗng hoặc hàm cụ thể của bạn
          return BlocProvider<HomePageBloc>.value(
              value: homePageBloc, child: HomePage(callback));
        },
      ),
      GetPage(
        name: MenuPage.MenuPageRoute,
        page: () {
          callback(int index) {} // Hàm callback rỗng hoặc hàm cụ thể của bạn
          return BlocProvider<MenuPageBloc>.value(
              value: menuPageBloc, child: MenuPage(callback));
        },
      ),
      GetPage(
        name: ShelterDetailPage.ShelterDetailPageRoute,
        page: () {
          final shelterPageBloc =
              BlocProvider.of<ShelterPageBloc>(Get.context!);
          final ShelterModel shelter = ShelterModel();
          return ShelterDetailPage(bloc: shelterPageBloc, shelter: shelter);
        },
      ),
    ];
  }
}
