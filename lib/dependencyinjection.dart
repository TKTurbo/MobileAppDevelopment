import 'package:get_it/get_it.dart';
import 'package:mobile_app_development/controllers/accountcontroller.dart';
import 'package:mobile_app_development/controllers/logincontroller.dart';
import 'package:mobile_app_development/controllers/registercontroller.dart';
import 'package:mobile_app_development/controllers/rentalcontroller.dart';
import 'package:mobile_app_development/services/apiservice.dart';
import 'package:mobile_app_development/services/authservice.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<AuthService>(AuthService());
    getIt.registerSingleton<ApiService>(ApiService());

    getIt.registerSingleton<AccountController>(AccountController());
    getIt.registerSingleton<LoginController>(LoginController());
    getIt.registerSingleton<RegisterController>(RegisterController());
    getIt.registerSingleton<RentalController>(RentalController());
  }
}