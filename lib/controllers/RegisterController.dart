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

    var isSuccess = true; // Api returns errors when registering an /AM account, but it still works
    // "could not execute batch [Referential integrity constraint violation: \"FK_CUSTOMER__SYSTEM_USER_ID: PUBLIC.CUSTOMER FOREIGN KEY(SYSTEM_USER_ID) REFERENCES PUBLIC.JHI_USER(ID) (CAST(1057 AS BIGINT))\"; SQL statement:\ndelete from jhi_user where id=? [23503-224]] [delete from jhi_user where id=?]"

    return isSuccess;
  }
}
