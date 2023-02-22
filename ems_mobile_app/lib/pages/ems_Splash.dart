import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'loading_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Container(
            height: 244,
            width: 244,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset("assets/images/EMSCOD.png"),
            ),
          ),
        splashIconSize: 244,
        duration:2500 ,
        nextScreen:  LoadingPage(),
        // nextScreen: const LoginScreen(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}



