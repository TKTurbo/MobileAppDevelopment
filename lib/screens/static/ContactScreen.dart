import 'package:flutter/material.dart';

import '../../widgets/MainBottomNavigation.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Contactgegevens AutoMaat',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text('Phone: +1234567890', style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 10),
              Text('Email: example@email.com', style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 10),
              Text('Address: 1234 Main St, City, Country', style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavigation(
        initialIndex: 2,
      ),
    );
  }
}
