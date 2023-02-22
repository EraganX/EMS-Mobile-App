
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/message.dart';
import '../models/messages_response.dart';
import '../models/user_model.dart';
import 'auth_service.dart';

class ChatService with ChangeNotifier {
  late User userFrom;

  Future<List<Message>> getChat(String uid) async {
    try {
      final response = await http
          .get(Uri.parse('${Environment.apiUrl}/messages/$uid'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? 'Default Value'
      });
      final data = messagesResponseFromJson(response.body);
      return data.msj;
    } catch (e) {
      return [];
    }
  }
}
