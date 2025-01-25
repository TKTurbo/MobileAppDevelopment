import 'package:mobile_app_development/helpers/cache/ICacheStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCacheStorage extends ICacheStorage {

  @override
  Future<String?> getString(String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(endpoint);
  }

  @override
  void setString(String endpoint, String body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(endpoint, body);
  }

}