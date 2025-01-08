import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteHelper {
  // When showing a snackbar before or after navigating, it is sometimes dismissed.
  // This helper encapsulates global logic to show a snackbar after a route
  static void showSnackBarAndNavigate(
      BuildContext context, String message, String route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    Future.delayed(Duration.zero, () {
      context.go(route);
    });
  }
}
