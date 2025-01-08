import 'dart:convert';

import 'package:mobile_app_development/controllers/HttpResponseExtension.dart';
import 'package:mobile_app_development/services/ApiService.dart';
import '../DependencyInjection.dart';
import '../models/sendonly/RegisterModel.dart';
import '../services/AuthService.dart';

class RegisterController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();
  final _authService = DependencyInjection.getIt.get<AuthService>();

  Future<bool> register(RegisterModel registerModel) async {
    final response = await apiService.register(registerModel);

    if (response.isSuccessful()) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      if (token != null) {
        await _authService.saveToken(token);
      }
    }

    return response.isSuccessful();
  }
}
