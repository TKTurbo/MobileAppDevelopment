import 'package:get_it/get_it.dart';
import 'package:mobile_app_development/controllers/AccountController.dart';
import 'package:mobile_app_development/controllers/ChangePasswordController.dart';
import 'package:mobile_app_development/controllers/InspectionController.dart';
import 'package:mobile_app_development/controllers/LoginController.dart';
import 'package:mobile_app_development/controllers/PasswordResetController.dart';
import 'package:mobile_app_development/controllers/RegisterController.dart';
import 'package:mobile_app_development/controllers/RentalController.dart';
import 'package:mobile_app_development/helpers/cache/CacheHelper.dart';
import 'package:mobile_app_development/helpers/SharedPreferencesCacheStorage.dart';
import 'package:mobile_app_development/services/api/ApiService.dart';
import 'package:mobile_app_development/services/auth/AuthService.dart';
import 'package:mobile_app_development/services/auth/AuthStorage.dart';
import 'package:mobile_app_development/services/notification/NotificationService.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    // Services
    getIt.registerSingleton<AuthService>(AuthService(AuthStorage()));
    getIt.registerSingleton<ApiService>(ApiService());
    getIt.registerSingleton<NotificationService>(NotificationService());

    //Helpers
    getIt.registerSingleton<CacheHelper>(CacheHelper(SharedPreferencesCacheStorage()));

    // Controllers
    getIt.registerSingleton<ChangePasswordController>(
        ChangePasswordController());
    getIt.registerSingleton<LoginController>(LoginController());
    getIt.registerSingleton<RegisterController>(RegisterController());
    getIt.registerSingleton<RentalController>(RentalController());
    getIt.registerSingleton<AccountController>(AccountController());
    getIt.registerSingleton<InspectionController>(InspectionController());
    getIt.registerSingleton<PasswordResetController>(PasswordResetController());
  }
}
