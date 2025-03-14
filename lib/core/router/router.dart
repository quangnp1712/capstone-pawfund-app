import 'package:capstone_pawfund_app/features/presentation/pages/landing_navigation_bottom/bloc/landing_navigation_bottom_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../features/presentation/pages/landing_navigation_bottom/landing_navigation_bottom.dart';
import '../../features/presentation/pages/splash_page.dart';

class RouteGenerator {
  final LandingNavigationBottomBloc landingNavigationBottomBloc =
      LandingNavigationBottomBloc();

  List<GetPage> routes() {
    return [
      GetPage(
        name: SplashPage.SplashPageRoute,
        page: () => const SplashPage(),
      ),
      GetPage(
        name: LandingPage.LandingPageRoute,
        page: () => BlocProvider<LandingNavigationBottomBloc>.value(
            value: landingNavigationBottomBloc, child: const LandingPage()),
      ),
    ];
  }
}
