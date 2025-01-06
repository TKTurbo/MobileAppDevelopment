import 'dart:io';

import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_development/models/AccountInfoModel.dart';
import 'package:mobile_app_development/models/InspectionModel.dart';
import 'package:mobile_app_development/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ChangePasswordModel.dart';
import '../models/RentalModel.dart';

import '../DependencyInjection.dart';

class ApiService {
  final _authService = DependencyInjection.getIt.get<AuthService>();
  final String baseUrl = 'https://mad.thomaskreder.nl/api';

  Future<http.Response> getAllCars() async => await _get('/cars');

  //TODO hack. Remove when rentals can be acquired via a customer
  Future<http.Response> getAllRentals() async => await _get('/rentals');

  Future<http.Response> getCar(int id) async => await _get('/cars/$id');

  Future<http.Response> getRental(int id) async => await _get('/rentals/$id');

  Future<http.Response> getRentalCount() async => await _get('/rentals/count');

  Future<http.Response> getCurrentCustomer() async => await _get('/AM/me');

  Future<http.Response> rentCar(RentalModel rental) async =>
      await _post('/rentals', rental.toJson());

  Future<http.Response> changePassword(
          ChangePasswordModel changePasswordModel) async =>
      await _post('/account/change-password', changePasswordModel.toJson());

  Future<http.Response> changeAccountInfo(
          AccountInfoModel accountInfoModel) async =>
      await _post('/AM/account', accountInfoModel.toJson());

  Future<http.Response> addInspection(InspectionModel inspectionModel) async =>
      await _post('/inspections', inspectionModel.toJson());

  Future<http.Response> register(registerModel) async =>
      await _post('/AM/register', registerModel.toJson(), includeAuth: false);

  Future<http.Response> login(loginModel) async =>
      await _post('/authenticate', loginModel.toJson(), includeAuth: false);

  // Helper method to build full URL
  Uri _buildUri(String endpoint) => Uri.parse('$baseUrl$endpoint');

  // Get request
  Future<http.Response> _get(String endpoint, {bool includeAuth = true}) async {
    var isOnline = await this.isOnline();

    if (!isOnline) {
      // Only use app cache if the app is offline because we like up-to-date data
      return getCachedResponse(endpoint);
    }

    final headers = await _getHeaders(includeAuth: includeAuth);
    var response = await http.get(
      _buildUri(endpoint),
      headers: headers,
    );

    // Set the cached response
    setCachedResponse(endpoint, response);

    return response;
  }

  // Post request
  Future<http.Response> _post(String endpoint, String body,
      {bool includeAuth = true}) async {
    final headers = await _getHeaders(includeAuth: includeAuth);
    return await http.post(_buildUri(endpoint), headers: headers, body: body);
  }

  // Get headers
  Future<Map<String, String>> _getHeaders({bool includeAuth = true}) async {
    final headers = {'Content-Type': 'application/json'};
    if (includeAuth) {
      final token = await _authService.getToken();
      headers['Authorization'] = 'Bearer ${token.toString()}';
    }
    return headers;
  }

  Future<http.Response> getCachedResponse(String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedResponse = prefs.getString(endpoint);

    if (cachedResponse != null) {
      return http.Response(cachedResponse, 200);
    } else {
      return http.Response('No cached data available', 404);
    }
  }

  Future setCachedResponse(String endpoint, http.Response response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(endpoint, response.body);
  }

  Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('mad.thomaskreder.nl');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
