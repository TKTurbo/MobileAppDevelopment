import 'package:flutter/material.dart';
import 'package:mobile_app_development/screens/rental_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO kijken of user een rental heeft
    bool hasRental = false;
    return hasRental ? const Center(
      child: Text('Home'),
    ) : RentalView();
  }
}