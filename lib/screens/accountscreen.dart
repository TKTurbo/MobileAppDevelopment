import 'package:flutter/material.dart';

import '../widgets/mainbottomnavigation.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Account'),
      ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 2,
      ),
    );
  }
}