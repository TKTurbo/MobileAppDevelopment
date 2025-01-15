import 'dart:convert';

class AccountInfoModel {
  int id;
  String login;
  String firstName;
  String lastName;
  String email;
  String? imageUrl;
  String langKey;

  AccountInfoModel({
    required this.id,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.imageUrl,
    required this.langKey,
  });

  static fromJson(Map<String, dynamic> data) {
    return AccountInfoModel(
      id: data['id'],
      login: data['login'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      imageUrl: data['imageUrl'],
      langKey: data['langKey'],
    );
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'login': login,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageUrl': imageUrl,
      'langKey': langKey,
    });
  }
}
