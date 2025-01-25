import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'IAuthStorage.dart';

class AuthStorage extends AbstractStorage {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> delete(String key) async {
    _storage.delete(key: key);
  }

  @override
  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  @override
  Future<void> write(String key, String value) async {
    _storage.write(key: key, value: value);
  }

}