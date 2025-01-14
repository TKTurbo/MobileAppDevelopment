import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _tokenKey = 'bearer_token';
  final _storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    var token = await _storage.read(key: _tokenKey);

    // Remove token when expired. Will probably never happen due to it being more than a year in the future.
    if (isTokenExpired(token)) {
      clearToken();
      return null;
    }

    return token;
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<bool> isLoggedIn() async {
    var key = await _storage.read(key: _tokenKey);

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

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return now >= payload['exp'];
  }
}
