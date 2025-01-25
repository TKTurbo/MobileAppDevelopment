import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mobile_app_development/helpers/cache/CacheHelper.dart';
import 'package:mobile_app_development/helpers/cache/MockCacheStorage.dart';

void main() async {
  test('Given cache is empty when setCachedResponse is then return 200', () async {
    CacheHelper cacheHelper = CacheHelper(MockCacheStorage());
    String endpoint = "test.com";
    Response response = Response("test", 200);

    cacheHelper.setCachedResponse(endpoint, response);
    Response cachedResponse = await cacheHelper.getCachedResponse(endpoint);
    expect(cachedResponse.statusCode, 200);
  });

  test('Given there is no cache available when getCachedResponse is called then return 404', () async {
    CacheHelper cacheHelper = CacheHelper(MockCacheStorage());
    String endpoint = "test.com";
    Response cachedResponse = await cacheHelper.getCachedResponse(endpoint);

    expect(cachedResponse.statusCode, 404);
  });
}