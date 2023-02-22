
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/user_model.dart';
import '../models/users_response.dart';
import 'auth_service.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final response = await http
          .get(Uri.parse('${Environment.socketUrl}/api/users'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? 'Default Value',
      });

      final data = usersResponseFromJson(response.body);

      return data.users;
    } catch (e) {
      return [];
    }
  }
}
