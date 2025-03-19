import 'package:capstone_pawfund_app/core/router/router.dart';
import 'package:capstone_pawfund_app/features/data/services/splash_service.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/shared_preferences_helper.dart';
import 'package:capstone_pawfund_app/features/presentation/pages/splash_page.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'features/presentation/pages/landing_navigation_bottom/bloc/landing_navigation_bottom_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await SharedPreferencesHelper.instance.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  _FBSignAnonymous();
  runApp(const MyApp());
}

Future<void> _FBSignAnonymous() async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    User? user = userCredential.user;
    print('Đăng nhập ẩn danh thành công: ${user!.uid}');
  } catch (e) {
    print('Lỗi không xác định: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ISplashService splashService = SplashService();

  @override
  void initState() {
    super.initState();
    splashService.initialization();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LandingNavigationBottomBloc()),
        ],
        child: GetMaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi'),
          ],
          getPages: RouteGenerator().routes(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
            textTheme: GoogleFonts.quicksandTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          initialRoute: SplashPage.SplashPageRoute,
        ),
      );
    });
  }
}
