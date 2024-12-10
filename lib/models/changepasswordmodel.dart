import 'dart:convert';

class ChangePasswordModel {
  String currentPassword;
  String newPassword;

  ChangePasswordModel({
    required this.currentPassword,
    required this.newPassword,
  });

  String toJson() {
    return jsonEncode(
        {'currentPassword': currentPassword, 'newPassword': newPassword});
  }
}
