import 'dart:convert';

import '../../helpers/DateTimeHelper.dart';
import 'IAuthStorage.dart';

class AuthService {
  static const _tokenKey = 'bearer_token';
  AbstractStorage _storage;

  AuthService(this._storage);

  DateTimeHelper dateTimeHelper = DateTimeHelper();

  void setDateTime(DateTime dateTime) {
    dateTimeHelper.setDateTime(dateTime);
  }

  Future<String?> getToken() async {
    var token = await _storage.read(_tokenKey);
    // Remove token when expired. Will probably never happen due to it being more than a year in the future.
    if (isTokenExpired(token)) {
      clearToken();
      return null;
    }

    return token;
  }

  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  Future<void> clearToken() async {
    await _storage.delete(_tokenKey);
  }

  Future<bool> isLoggedIn() async {
    var key = await _storage.read(_tokenKey);

    return key != null;
  }

  Map<String, dynamic>? decodeToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return null;

    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return jsonDecode(payload) as Map<String, dynamic>?;
  }

  bool isTokenExpired(String? token) {
    if (token == null) return true;

    final payload = decodeToken(token);
    if (payload == null || payload['exp'] == null) return true;
    final now = dateTimeHelper.now().millisecondsSinceEpoch ~/ 1000;
    return now >= payload['exp'];
  }
}