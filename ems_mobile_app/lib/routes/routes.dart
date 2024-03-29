import 'package:ems_mobile_app/pages/ems_Profile.dart';
import 'package:ems_mobile_app/pages/ems_SignUp.dart';
import 'package:ems_mobile_app/pages/ems_Splash.dart';
import 'package:flutter/material.dart';

import '../pages/chat_page.dart';
import '../pages/ems_Dashboard.dart';
import '../pages/ems_Login.dart';
import '../pages/loading_page.dart';
import '../pages/newroom_page.dart';
import '../pages/users_page.dart';


final Map<String, Widget Function(BuildContext)> routes = {
  UsersPage.routeName: (_) => UsersPage(),
  ChatPage.routeName: (_) => ChatPage(),
  SignUp.routeName: (_) => const SignUp(),
  LoadingPage.routeName: (_) => LoadingPage(),
  NewroomPage.routeName: (_) => const NewroomPage(),
  SplashScreen.routeName: (_) => const SplashScreen(),
  DashboardScreen.routeName:(_)=> DashboardScreen(),
  Profile.routeName:(_)=>Profile(),
};
