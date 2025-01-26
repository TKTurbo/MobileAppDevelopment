import 'dart:convert';
import 'package:mobile_app_development/extensions/HttpResponseExtension.dart';
import 'package:mobile_app_development/services/ApiService.dart';
import 'package:mobile_app_development/services/auth/AuthService.dart';

import '../DependencyInjection.dart';
import '../models/sendonly/LoginModel.dart';

class LoginController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();
  final _authService = DependencyInjection.getIt.get<AuthService>();

  Future<bool> login(LoginModel loginModel) async {
    final response = await apiService.login(loginModel);

    bool isSuccess = response.isSuccessful();

    if (isSuccess) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['id_token'];
      if (token != null) {
        await _authService.saveToken(token);
      }
    }

    return isSuccess;
  }

  Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }
}
