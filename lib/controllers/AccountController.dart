import 'dart:convert';

import 'package:mobile_app_development/services/ApiService.dart';
import '../DependencyInjection.dart';
import '../models/AccountInfoModel.dart';
import '../services/AuthService.dart';

class AccountController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();
  final _authService = DependencyInjection.getIt.get<AuthService>();

  Future<AccountInfoModel> getAccountInfo() async {
    final response = await apiService.getCurrentCustomer();

    var json = jsonDecode(response.body)['systemUser'];

    return AccountInfoModel(
        id: json['id'],
        login: json['login'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        imageUrl: json['imageUrl'],
        langKey: json['langKey']);
  }

  Future<bool> changeAccountInfo(AccountInfoModel accountInfoModel) async {
    var response = await apiService.changeAccountInfo(accountInfoModel);
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future logout() async {
    _authService.clearToken();
  }
}
