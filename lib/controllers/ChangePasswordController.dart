import 'package:mobile_app_development/services/ApiService.dart';
import '../DependencyInjection.dart';
import '../models/sendonly/ChangePasswordModel.dart';

class ChangePasswordController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

  Future<bool> changePassword(ChangePasswordModel changePasswordModel) async {
    final response = await apiService.changePassword(changePasswordModel);

    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
