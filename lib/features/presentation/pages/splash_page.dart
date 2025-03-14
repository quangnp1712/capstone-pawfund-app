import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String SplashPageRoute = "/splash-page";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/bg.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/logo_1.png",
              width: size.width * 0.6,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            const SpinKitSpinningLines(
              color: Colors.black,
              size: 60.0,
            )
          ]),
        ],
      ),
    );
  }
}
