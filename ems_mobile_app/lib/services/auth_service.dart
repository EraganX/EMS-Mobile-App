
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/login_response.dart';
import '../models/user_model.dart';
//import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService with ChangeNotifier {
  late User user;
  bool _loggin = false;

  final _storage = const FlutterSecureStorage();

  bool get loggin => _loggin;
  set loggin(value) {
    _loggin = value;
    notifyListeners();
  }

  Future login(String email, String password) async {
    loggin = true;

    final request = {'email': email, 'password': password};

    final response = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    loggin = false;

    if (response.statusCode == 200) {
      final data = loginResponseFromJson(response.body);
      user = data.user;
      await _saveToken(data.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password, String git, String role) async {
    loggin = true;
    final request = {'name': name, 'email': email, 'password': password, 'git':git, "role":role,};

    final response = await http.post(
        Uri.parse('${Environment.apiUrl}/login/new'),
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});
    loggin = false;

    if (response.statusCode == 200) {
      final data = loginResponseFromJson(response.body);
      user = data.user;
      await _saveToken(data.token);
      return true;
    } else {
      return jsonDecode(response.body)['msg'];
    }
  }

  Future _saveToken(String token) async {
    var writeToken = await _storage.write(key: 'token', value: token);
    var readToken = await _storage.read(key: 'token');
    return writeToken;
  }

  Future<bool> logged() async {
    var token = await _storage.read(key: 'token');
    token ??= "na";

    final response = await http.get(
        Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (response.statusCode == 200) {
      final data = loginResponseFromJson(response.body);
      user = data.user;
      await _saveToken(data.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  //si quiero el token sin referenciar a la clase, la hago static
  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    return await _storage.read(key: 'token');
  }

  //si quiero el token sin referenciar a la clase, la hago static
  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }
}
