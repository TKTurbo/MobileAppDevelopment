import 'package:flutter/material.dart';
import 'package:mobile_app_development/screens/accountscreen.dart';
import 'package:mobile_app_development/screens/mapscreen.dart';

import 'screens/homescreen.dart';
import 'screens/loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final bool isLoggedIn = true; // Determine if the user is logged in

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? LoggedInContext() : LoginScreen(),
    );
  }
}

class LoggedInContext extends StatefulWidget {
  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedInContext> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeScreen(),
    MapScreen(),
    AccountScreen(),
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