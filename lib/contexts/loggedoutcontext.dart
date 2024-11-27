import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app_development/screens/loginscreen.dart';
import 'package:mobile_app_development/screens/registerscreen.dart';

import '../screens/accountscreen.dart';
import '../screens/homescreen.dart';
import '../screens/mapscreen.dart';

class LoggedOutContext extends StatefulWidget {
  @override
  _LoggedOutState createState() => _LoggedOutState();
}

class _LoggedOutState extends State<LoggedOutContext> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    LoginScreen(),
    RegisterScreen()
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
            icon: Icon(Icons.person),
            label: 'Inloggen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Registreren',
          ),
        ],
      ),
    );
  }
}