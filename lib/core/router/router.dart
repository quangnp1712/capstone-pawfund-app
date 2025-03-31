import 'package:capstone_pawfund_app/features/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/authentication_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/login_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/register_page.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/verifiction_email_page.dart';
import 'package:capstone_pawfund_app/features/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/home_page/home_page.dart';
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
        name: HomePage.HomePageRoute,
        page: () {
          callback(int index) {} // Hàm callback rỗng hoặc hàm cụ thể của bạn
          return BlocProvider<HomePageBloc>.value(
              value: homePageBloc, child: HomePage(callback));
        },
      ),
      GetPage(
        name: LoginPage.LoginPageRoute,
        page: () => BlocProvider<AuthenticationBloc>.value(
          value: authenticationBloc,
          child: LoginPage(
            bloc: authenticationBloc,
          ),
        ),
      ),
      GetPage(
        name: RegisterPage.RegisterPageRoute,
        page: () => BlocProvider<AuthenticationBloc>.value(
            value: authenticationBloc,
            child: RegisterPage(bloc: authenticationBloc)),
      ),
      GetPage(
        name: VerifictionEmailPage.VerifictionEmailPageRoute,
        page: () => BlocProvider<AuthenticationBloc>.value(
            value: authenticationBloc,
            child: VerifictionEmailPage(bloc: authenticationBloc, email: "")),
      ),
    ];
  }
}
