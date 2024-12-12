import 'package:mobile_app_development/services/ApiService.dart';
import '../DependencyInjection.dart';
import '../models/AccountInfoModel.dart';
import '../services/AuthService.dart';

class AccountController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();
  final _authService = DependencyInjection.getIt.get<AuthService>();

  Future<AccountInfoModel> getAccountInfo() async {
    final response = await apiService.getAccountInfo();

    return AccountInfoModel.fromJson(response.body);
  }

  Future logout() async {
    _authService.clearToken();
  }
}
