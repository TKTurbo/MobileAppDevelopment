import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://192.168.2.71:8080';

  Future<http.Response> register(login, firstName, lastName, email, langKey, password) async {
    final response = await http.post(
      Uri.parse(baseUrl + "/api/AM/register"),
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
    return response;
  }
}