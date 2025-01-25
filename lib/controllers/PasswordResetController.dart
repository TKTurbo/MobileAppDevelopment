import 'package:mobile_app_development/extensions/HttpResponseExtension.dart';

import '../DependencyInjection.dart';
import '../services/api/ApiService.dart';

class PasswordResetController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

  Future<bool> resetPassword(String email) async {
    final response = await apiService.resetPassword(email);

    return response.isSuccessful();
  }
}
