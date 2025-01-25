import 'dart:io';

import 'package:http/http.dart' as http;

import 'ICacheStorage.dart';

class CacheHelper {
  ICacheStorage prefs;

  CacheHelper(this.prefs);

  Future<http.Response> getCachedResponse(String endpoint) async {
    String? cachedResponse = await prefs.getString(endpoint);

    if (cachedResponse != null) {
      return http.Response(cachedResponse, 200);
    } else {
      return http.Response('No cached data available', 404);
    }
  }

  Future setCachedResponse(
      String endpoint, http.Response response) async {
    prefs.setString(endpoint, response.body);
  }

  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('mad.thomaskreder.nl');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
