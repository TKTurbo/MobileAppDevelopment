import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static Future<http.Response> getCachedResponse(String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedResponse = prefs.getString(endpoint);

    if (cachedResponse != null) {
      return http.Response(cachedResponse, 200);
    } else {
      return http.Response('No cached data available', 404);
    }
  }

  static Future setCachedResponse(
      String endpoint, http.Response response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
