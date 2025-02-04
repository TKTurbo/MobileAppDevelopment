import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/LoginController.dart';
import '../DependencyInjection.dart';
import '../helpers/FormHelper.dart';
import '../helpers/RouteHelper.dart';
import '../models/sendonly/LoginModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _controller =
      DependencyInjection.getIt.get<LoginController>();
  final LoginModel _loginModel = LoginModel(username: '', password: '');

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
                  'Inloggen',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextButton(
                  onPressed: () => context.go('/register'),
                  child: const Text('Nog geen account?'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormHelper.buildTextField('Gebruikersnaam', (value) {
                        _loginModel.username = value!;
                      }),
                      FormHelper.buildTextField('Wachtwoord', (value) {
                        _loginModel.password = value!;
                      }, obscureText: true),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: () => _handleSubmit(context),
                          child: const Text('Inloggen'),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/password_reset'),
                  child: const Text('Wachtwoord vergeten?'),
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

    var loginSuccess = await _controller.login(_loginModel);

    if (loginSuccess) {
      RouteHelper.showSnackBarAndNavigate(
          context, 'Succesvol ingelogd.', '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gebruikersnaam of wachtwoord verkeerd')),
      );
    }
  }
}
