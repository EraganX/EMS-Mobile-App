import 'package:ems_mobile_app/pages/ems_Splash.dart';
import 'package:ems_mobile_app/pages/loading_page.dart';
import 'package:ems_mobile_app/routes/routes.dart';
import 'package:ems_mobile_app/services/auth_service.dart';
import 'package:ems_mobile_app/services/chat_service.dart';
import 'package:ems_mobile_app/services/room_service.dart';
import 'package:ems_mobile_app/services/socket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'colours/Colours.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  // FlutterNativeSplash.remove();
  runApp(MyApp());
}

Future initialization(BuildContext? context) async {
  //  Load Resources
  await Future.delayed(Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => SocketService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatService(),
        ),
        ChangeNotifierProvider(
          create: (_) => RoomService(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              accentColor: primaryColorAC,
              primarySwatch: Colors.deepOrange,
              brightness: Brightness.light),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: LoadingPage.routeName,
        routes: routes,
      ),
    );
  }
}
