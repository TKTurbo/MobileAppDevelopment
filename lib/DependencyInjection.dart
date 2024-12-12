import 'package:get_it/get_it.dart';
import 'package:mobile_app_development/controllers/AccountController.dart';
import 'package:mobile_app_development/controllers/ChangePasswordController.dart';
import 'package:mobile_app_development/controllers/LoginController.dart';
import 'package:mobile_app_development/controllers/RegisterController.dart';
import 'package:mobile_app_development/controllers/RentalController.dart';
import 'package:mobile_app_development/services/ApiService.dart';
import 'package:mobile_app_development/services/AuthService.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<AuthService>(AuthService());
    getIt.registerSingleton<ApiService>(ApiService());

    getIt.registerSingleton<ChangePasswordController>(ChangePasswordController());
    getIt.registerSingleton<LoginController>(LoginController());
    getIt.registerSingleton<RegisterController>(RegisterController());
    getIt.registerSingleton<RentalController>(RentalController());
    getIt.registerSingleton<AccountController>(AccountController());
  }
}