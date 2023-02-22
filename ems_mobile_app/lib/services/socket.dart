import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../global/environment.dart';
import 'auth_service.dart';

enum ServerStatus { Online, Offline, Conecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Conecting;
  ServerStatus get serverStatus => _serverStatus;

  late IO.Socket socket;

  void connect(String room) async {
    //get the token from storage.
    final token = await AuthService.getToken();

    if (kIsWeb) {
      print('Conectant al socket... token = ${token}');
      print('Conectant al room... token = ${room}');

      socket = IO.io(Environment.socketUrl, <String, dynamic>{
        'transports': ['polling'],
        'autoConnect': false,
        'forceNew': true,
        'extraHeaders': {
          'x-token': token,
          'room': room,
        }
      });
    } else {
      // for No Web => run with ".setTransports"...
      socket = IO.io(Environment.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'forceNew': true,
        'extraHeaders': {
          'x-token': token,
          'room': room,
        }
      });
    }

    socket.connect();

    socket.onConnect((data) => {
          print('Connected to socket server'),
          _serverStatus = ServerStatus.Online,
        });

    socket.onDisconnect((data) => {
          print('Disconnected from socket server'),
          _serverStatus = ServerStatus.Offline,
        });
  }

  void disconnect() {
    print('Reconnecting socket...');
    socket.disconnect();
    print('Disconnected socket...');
  }
}
