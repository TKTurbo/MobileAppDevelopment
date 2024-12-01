import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app_development/services/authservice.dart';

class ApiService {
  final _authService = AuthService();

  final String baseUrl = 'https://mad.thomaskreder.nl';

  Future<http.Response> register(
      login, firstName, lastName, email, langKey, password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/AM/register"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'login': login,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'langKey': langKey,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token']; // Adjust based on your API response
      if (token != null) {
        await _authService.saveToken(token);
      }
    }

    return response;
  }

  Future<http.Response> login(
      login, password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/authenticate"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': login,
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['id_token']; // Adjust based on your API response
      if (token != null) {
        await _authService.saveToken(token);
      }
    }

    return response;
  }
}
