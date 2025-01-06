import 'dart:convert';

import 'package:mobile_app_development/services/ApiService.dart';
import '../DependencyInjection.dart';
import '../models/sendonly/LoginModel.dart';
import '../services/AuthService.dart';

class LoginController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();
  final _authService = DependencyInjection.getIt.get<AuthService>();

  Future<bool> login(LoginModel loginModel) async {
    final response = await apiService.login(loginModel);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['id_token'];
      if (token != null) {
        await _authService.saveToken(token);
      }
    }

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }
}
