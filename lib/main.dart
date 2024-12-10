import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/screens/accountscreen.dart';
import 'package:mobile_app_development/screens/searchscreen.dart';
import 'package:mobile_app_development/screens/cardetailsscreen.dart';
import 'package:mobile_app_development/screens/homescreen.dart';
import 'package:mobile_app_development/screens/loginscreen.dart';
import 'package:mobile_app_development/screens/registerscreen.dart';
import 'package:mobile_app_development/screens/rentalscreen.dart';

import 'dependencyinjection.dart';

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/login',
  routes: [
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
      name: 'cars',
      path: '/cars',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      name: 'rentals',
      path: '/rentals',
      builder: (context, state) => const RentalScreen(),
    ),
    GoRoute(
      name: 'car_details',
      path: '/cars/:carId',
      builder: (context, state) => CarDetailsScreen(carId: state.pathParameters['carId']),
    ),
  ],
);

void main() {
  DependencyInjection.configure();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF6F82F8),
      ),
    );
  }
}