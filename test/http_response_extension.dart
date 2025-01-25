import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mobile_app_development/extensions/HttpResponseExtension.dart';

void main() async {
  test('Given status is 200 when isSuccessful is called then return true', () {
    Response response = Response('', 200);

    bool success = response.isSuccessful();

    expect(success, true);
  });

  test('Given status is 400 when isSuccessful is called then return false', () {
    Response response = Response('', 400);

    bool success = response.isSuccessful();

    expect(success, false);
  });
}