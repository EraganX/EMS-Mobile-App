// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.online,
    required this.name,
    required this.email,
    required this.uid,
    required this.time,
    this.role,//role
    this.git, //git
  });

  bool online;
  String name;
  String email;
  String uid;
  String time;
  String? git;//git
  String? role;//role

  factory User.fromJson(Map<String, dynamic> json) => User(
        online: json["online"],
        name: json["name"],
        email: json["email"],
        uid: json["uid"],
        time: json["time"],
        git: json["git"],//git
        role: json["role"],//role
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "name": name,
        "email": email,
        "uid": uid,
        "time": time,
        "git": git,//git
        "role": role,//role
      };
}
