import 'dart:convert';

class LoginModel {
  String username;
  String password;

  LoginModel({
    required this.username,
    required this.password,
  });

  String toJson() {
    return jsonEncode({'username': username, 'password': password});
  }
}
