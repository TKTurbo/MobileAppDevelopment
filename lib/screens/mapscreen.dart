import 'package:flutter/material.dart';

import '../widgets/mainbottomnavigation.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Kaart'),
      ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 1,
      ),
    );
  }
}