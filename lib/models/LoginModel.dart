import 'dart:convert';

class LoginModel {
  String username;
  String password;
  bool rememberMe = true;

  LoginModel({
    required this.username,
    required this.password,
  });

  String toJson() {
    return jsonEncode({'username': username, 'password': password, 'rememberMe': rememberMe});
  }
}