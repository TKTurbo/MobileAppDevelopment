import 'package:flutter/material.dart';
import 'package:mobile_app_development/widgets/CarsList.dart';

import '../widgets/MainBottomNavigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CarsList(),
      ),
      bottomNavigationBar: MainBottomNavigation(
        initialIndex: 0,
      ),
    );
  }
}