
import 'package:ems_mobile_app/pages/ems_Login.dart';
import 'package:ems_mobile_app/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../services/room_service.dart';
import '../../services/socket.dart';
import '../../widgets/button_sign.dart';
import '../../widgets/input.dart';
import '../helpers/show_alert.dart';



class NewroomPage extends StatelessWidget {
  const NewroomPage({Key? key}) : super(key: key);

  static const routeName = 'Newroom';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 1,
        // backgroundColor: const Color.fromARGB(255, 255, 166, 0),
        title: Text(
          "Flatter Chat - ${user.name}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                socketService.disconnect();
                AuthService.deleteToken();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 65,
                ),
                _Form(),
                const SizedBox(
                  height: 5,
                ),
              ]),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final roomService = Provider.of<RoomService>(context);
    final authService = Provider.of<AuthService>(context);
    return Center(
      child: Container(
        constraints: const BoxConstraints(minWidth: 180, maxWidth: 600),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(children: [
          Input(
            icon: Icons.drive_file_rename_outline_rounded,
            placeholder: 'Room Name',
            maxLenght: 16,
            controller: textController,
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 16,
          ),
          SignButton(
            label: 'New Room',
            press: () async {
              FocusScope.of(context).unfocus();
              final loginOK = await roomService.createRoom(textController.text);
              if (loginOK) {
                //navigate to the user screen
                Navigator.pushReplacementNamed(context, UsersPage.routeName);
              } else {
                showAlert(
                    context, 'Name taken', 'Enter a new name and try again');
              }
            },
          ),
        ]),
      ),
    );
  }
}
