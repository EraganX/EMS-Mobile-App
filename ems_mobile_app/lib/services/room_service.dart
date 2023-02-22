import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/room_model.dart';
import '../models/rooms_response.dart';
import 'auth_service.dart';

class RoomService with ChangeNotifier {
  //late User userFrom;

  Future createRoom(String name) async {
    //logeando = true;

    final request = {'groupname': name};

    final response = await http.post(Uri.parse('${Environment.apiUrl}/groups'),
        body: jsonEncode(request),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? 'Default Value',
        });
    //logeando = false;

    if (response.statusCode == 200) {
      return true;
    } else {
      return; // jsonDecode(response.body)['msg']
    }
  }

  Future<List<Room>> getRooms() async {
    try {
      final response = await http
          .get(Uri.parse('${Environment.socketUrl}/api/groups'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? 'Default Value',
      });

      final data = roomsResponseFromJson(response.body);

      return data.rooms;
    } catch (e) {
      return [];
    }
  }
}
