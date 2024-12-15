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

  factory AccountInfoModel.fromJson(json) {
    return AccountInfoModel(
      id: json['id'],
      login: json['login'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      langKey: json['langKey'],
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
