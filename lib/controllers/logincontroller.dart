import 'package:mobile_app_development/services/apiservice.dart';
import '../dependencyinjection.dart';
import '../models/loginmodel.dart';

class LoginController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

  Future<bool> login(LoginModel loginModel) async {
    final response = await apiService.login(loginModel);

    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
