import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _tokenKey = 'bearer_token';
  final _storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
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
}
