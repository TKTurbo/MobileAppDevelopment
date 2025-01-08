import 'package:http/http.dart';

extension HttpResponseExtension on Response {
  bool isSuccessful() {
    return statusCode >= 200 && statusCode < 300;
  }
}
