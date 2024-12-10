import 'package:mobile_app_development/services/apiservice.dart';
import '../models/registermodel.dart';

class RegisterController {
  final ApiService apiService = ApiService();

  Future<bool> register(RegisterModel registerModel) async {
    final response = await apiService.register(registerModel);
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
