import 'package:flutter/material.dart';
import 'package:mobile_app_development/screens/searchscreen.dart';

import '../widgets/mainbottomnavigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: SearchScreen(),
      ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 0,
      ),
    );
  }
}