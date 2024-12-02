import 'dart:convert';

class RegisterModel {
  String username;
  String firstname;
  String lastname;
  String email;
  String langkey;
  String password;

  RegisterModel({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.langkey,
    required this.password,
  });

  String toJson() {
    return jsonEncode({
      'login': username,
      'firstName': firstname,
      'lastName': lastname,
      'email': email,
      'langKey': langkey,
      'password': password,
    });
  }
}
