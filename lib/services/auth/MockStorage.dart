import 'IAuthStorage.dart';

class MockStorage extends AbstractStorage {
  Map<String, String> storage = {};

  @override
  Future<void> delete(String key) async {
    storage.remove(key);
  }

  @override
  Future<String?> read(String key) async {
    return storage[key];
  }

  @override
  Future<void> write(String key, String value) async {
    storage[key] = value;
  }

}