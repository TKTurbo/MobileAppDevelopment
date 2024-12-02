import 'package:flutter/material.dart';

import '../widgets/mainbottomnavigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Home'),
      ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 0,
      ),
    );
  }
}