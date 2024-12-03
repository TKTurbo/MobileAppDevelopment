import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app_development/services/authservice.dart';

class ApiService {
  final _authService = AuthService();

  final String baseUrl = 'https://mad.thomaskreder.nl';

  Future<http.Response> register(registerModel) async {
    final response = await http.post(Uri.parse("$baseUrl/api/AM/register"),
        headers: {'Content-Type': 'application/json'},
        body: registerModel.toJson());

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      if (token != null) {
        await _authService.saveToken(token);
      }
    }

    return response;
  }

  Future<http.Response> login(loginModel) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/authenticate"),
      headers: {'Content-Type': 'application/json'},
      body: loginModel.toJson(),
    );

    if (response.statusCode == 200) {
      // TODO: move token logic to controller?
      final responseBody = jsonDecode(response.body);
      final token = responseBody['id_token'];
      if (token != null) {
        await _authService.saveToken(token);
      }
    }

    return response;
  }
}
