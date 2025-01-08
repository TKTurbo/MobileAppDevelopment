import '../DependencyInjection.dart';
import '../services/ApiService.dart';

class PasswordResetController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

  Future<bool> resetPassword(String email) async {
    final response = await apiService.resetPassword(email);

    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
