import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/AccountController.dart';
import '../DependencyInjection.dart';
import '../widgets/MainBottomNavigation.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<AccountScreen> {
  final AccountController _controller = DependencyInjection.getIt.get<AccountController>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/contact'),
              child: const Text('Contactgegevens automaat'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/faq'),
              child: const Text('Veelgestelde vragen'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/rentalhistory'),
              child: const Text('Huurgeschiedenis'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/changeinfo'),
              child: const Text('Account info wijzigen'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/changepassword'),
              child: const Text('Wachtwoord wijzigen'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _controller.logout();
                context.go('/login');
              },
              child: const Text('Uitloggen'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 0,
      ),
    );
  }
}
