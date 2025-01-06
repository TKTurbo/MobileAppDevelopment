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

  static fromJson(accountInfo) {
    return AccountInfoModel(
      id: accountInfo['id'],
      login: accountInfo['login'],
      firstName: accountInfo['firstName'],
      lastName: accountInfo['lastName'],
      email: accountInfo['email'],
      imageUrl: accountInfo['imageUrl'],
      langKey: accountInfo['langKey'],
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
