import 'package:flutter/material.dart';
import 'contexts/loggedincontext.dart';
import 'contexts/loggedoutcontext.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isLoggedIn = true; // Determine if the user is logged in

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF6F82F8),
      ),
      home: isLoggedIn ? LoggedInContext() : LoggedOutContext(),
    );
  }
}
