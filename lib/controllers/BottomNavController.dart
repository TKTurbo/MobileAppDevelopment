import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavController {
  static void navigateTo(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/rentals');
        break;
      case 2:
        context.go('/account');
        break;
    }
  }
}
