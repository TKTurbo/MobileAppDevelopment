import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app_development/models/loginmodel.dart';
import 'package:mobile_app_development/services/authservice.dart';

import '../models/changepasswordmodel.dart';
import '../models/rentalmodel.dart';

import '../dependencyinjection.dart';

class ApiService {
  final _authService = DependencyInjection.getIt.get<AuthService>();
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

  Future<http.Response> getAllCars() async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/api/cars"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      }
    );

    return response;
  }

  Future<http.Response> getCar(id) async {
    final token = await _authService.getToken();
    final response = await http.get(
        Uri.parse("$baseUrl/api/cars/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.toString()}',
        }
    );

    return response;
  }

  Future<http.Response> getRentalCount() async {
    final token = await _authService.getToken();
    final response = await http.get(
        Uri.parse("$baseUrl/api/rentals/count"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.toString()}',
        }
    );

    return response;
  }

  Future<http.Response> getCurrentCustomer() async {
    final token = await _authService.getToken();
    final response = await http.get(
        Uri.parse("$baseUrl/api/AM/me"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.toString()}',
        }
    );

    return response;
  }

  Future<http.Response> rentCar(RentalModel rental) async {
    final token = await _authService.getToken();
    final response = await http.post(
        Uri.parse("$baseUrl/api/rentals"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.toString()}',
        },
        body: rental.toJson(),
    );

    return response;
  }

  Future<http.Response> changePassword(ChangePasswordModel changePasswordModel) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/api/account/change-password"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      },
      body: changePasswordModel.toJson(),
    );

    return response;
  }
}
