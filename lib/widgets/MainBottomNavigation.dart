import 'package:flutter/material.dart';
import '../controllers/BottomNavController.dart';

class MainBottomNavigation extends StatelessWidget {
  final int initialIndex;

  const MainBottomNavigation({
    super.key,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: initialIndex,
      onTap: (index) {
        BottomNavController.navigateTo(context, index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Zoeken',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Verhuur',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
    );
  }
}
