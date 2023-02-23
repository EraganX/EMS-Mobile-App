
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ems_mobile_app/pages/ems_Splash.dart';
import 'package:ems_mobile_app/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../services/socket.dart';

import 'ems_Dashboard.dart';
import 'ems_Login.dart';


class LoadingPage extends StatefulWidget {
  static const routeName = 'LoginScreen';

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center();
        },
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      Scaffold(
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
    });
  }


  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final auth = await authService.logged();
    if (auth) {
      socketService.connect("noroom");
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => DashboardScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginScreen(),
              // pageBuilder: (_, __, ___) => LoginScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
