import 'package:mobile_app_development/models/changepasswordmodel.dart';
import 'package:mobile_app_development/services/apiservice.dart';
import '../dependencyinjection.dart';

class AccountController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

  Future<bool> changePassword(ChangePasswordModel changePasswordModel) async {
    final response = await apiService.changePassword(changePasswordModel);

    print(response.body);

    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
