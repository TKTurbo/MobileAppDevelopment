import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/screens/AccountScreen.dart';
import 'package:mobile_app_development/screens/ChangeAccountInfoScreen.dart';
import 'package:mobile_app_development/screens/ChangePasswordScreen.dart';
import 'package:mobile_app_development/screens/PasswordResetScreen.dart';
import 'package:mobile_app_development/screens/static/ContactScreen.dart';
import 'package:mobile_app_development/screens/CreateInspectionScreen.dart';
import 'package:mobile_app_development/screens/static/FaqScreen.dart';
import 'package:mobile_app_development/screens/RentalDetailScreen.dart';
import 'package:mobile_app_development/screens/RentalHistoryScreen.dart';
import 'package:mobile_app_development/widgets/CarsList.dart';
import 'package:mobile_app_development/screens/CarDetailScreen.dart';
import 'package:mobile_app_development/screens/HomeScreen.dart';
import 'package:mobile_app_development/screens/LoginScreen.dart';
import 'package:mobile_app_development/screens/RegisterScreen.dart';
import 'package:mobile_app_development/screens/RentalScreen.dart';
import 'package:mobile_app_development/services/AuthService.dart';
import 'DependencyInjection.dart';

final authService = DependencyInjection.getIt.get<AuthService>();

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) async {
        if (await authService.isLoggedIn()) {
          return '/home';
        } else {
          return '/login';
        }
      },
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: 'password_reset',
      path: '/password_reset',
      builder: (context, state) => const PasswordResetScreen(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'account',
      path: '/account',
      builder: (context, state) => const AccountScreen(),
    ),
    GoRoute(
      name: 'changepassword',
      path: '/changepassword',
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      name: 'changeinfo',
      path: '/changeinfo',
      builder: (context, state) => const ChangeAccountInfoScreen(),
    ),
    GoRoute(
      name: 'cars',
      path: '/cars',
      builder: (context, state) => const CarsList(),
    ),
    GoRoute(
      name: 'rentals',
      path: '/rentals',
      builder: (context, state) => const RentalScreen(),
    ),
    GoRoute(
      name: 'car_details',
      path: '/cars/:carId',
      builder: (context, state) =>
          CarDetailsScreen(carId: int.parse(state.pathParameters['carId']!)),
    ),
    GoRoute(
      name: 'rental_details',
      path: '/rentals/:rentalId',
      builder: (context, state) => RentalDetailScreen(
          rentalId: int.parse(state.pathParameters['rentalId']!)),
    ),
    GoRoute(
      name: 'rental_history',
      path: '/rentalhistory',
      builder: (context, state) => const RentalHistoryScreen(),
    ),
    GoRoute(
      name: 'create_inspection_screen',
      path: '/createinspectionscreen',
      builder: (context, state) => const CreateInspectionScreen(),
    ),
    GoRoute(
      name: 'faq',
      path: '/faq',
      builder: (context, state) => const FaqScreen(),
    ),
    GoRoute(
      name: 'contact',
      path: '/contact',
      builder: (context, state) => const ContactScreen(),
    ),
  ],
);

GoRouter getRouter() {
  return _router;
}
