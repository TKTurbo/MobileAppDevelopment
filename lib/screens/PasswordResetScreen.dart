import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/LoginController.dart';
import '../DependencyInjection.dart';
import '../controllers/PasswordResetController.dart';
import '../helpers/FormHelper.dart';
import '../helpers/RouteHelper.dart';
import '../models/sendonly/LoginModel.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  PasswordResetState createState() => PasswordResetState();
}

class PasswordResetState extends State<PasswordResetScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PasswordResetController _controller =
      DependencyInjection.getIt.get<PasswordResetController>();

  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlueWheels'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.all(32.0),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Reset wachtwoord',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormHelper.buildTextField('Email', (value) {
                        email = value!;
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: () => _handleSubmit(context),
                          child: const Text('Wachtwoord reset aanvragen'),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Terug naar inloggen'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    var resetSuccess = await _controller.resetPassword(email);

    if (resetSuccess) {
      RouteHelper.showSnackBarAndNavigate(
          context,
          'Als dit e-mailadres bestaat krijg je een mail met een reset-link',
          '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Er ging iets mis')),
      );
    }
  }
}
