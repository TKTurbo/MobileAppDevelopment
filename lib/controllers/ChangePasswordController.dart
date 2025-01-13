import 'package:mobile_app_development/controllers/HttpResponseExtension.dart';
import 'package:mobile_app_development/services/ApiService.dart';
import 'package:mobile_app_development/services/AuthService.dart';
import '../DependencyInjection.dart';
import '../models/sendonly/ChangePasswordModel.dart';

class ChangePasswordController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();
  final AuthService authService = DependencyInjection.getIt.get<AuthService>();

  Future<bool> changePassword(ChangePasswordModel changePasswordModel) async {
    final response = await apiService.changePassword(changePasswordModel);

    var isSuccess = response.isSuccessful();

    if (isSuccess) {
      authService.clearToken();
    }

    return isSuccess;
  }
}
