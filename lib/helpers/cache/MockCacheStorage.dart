import 'package:mobile_app_development/helpers/cache/ICacheStorage.dart';

class MockCacheStorage extends ICacheStorage {
  Map<String, String> cache = {};

  @override
  Future<String?> getString(String endpoint) async {
    return cache[endpoint];
  }

  @override
  void setString(String endpoint, String body) {
    cache[endpoint] = body;
  }
  
}