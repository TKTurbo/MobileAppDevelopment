import 'package:flutter/material.dart';

import '../screens/accountscreen.dart';
import '../screens/homescreen.dart';
import '../screens/mapscreen.dart';

class LoggedInContext extends StatefulWidget {
  const LoggedInContext({super.key});

  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedInContext> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const MapScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Kaart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}