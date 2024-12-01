import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/services/apiservice.dart';

import '../services/authservice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ApiService apiService = ApiService();
    String username = '';
    String password = '';

    Future<void> submitForm() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save(); // Save the form data

        var response = await apiService.login(username, password);

        print(response.body);

        var service = AuthService();
        var token = await service.getToken();
        print("Token: " + token!);
      }
    }

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
              child: Column(children: [
                Text(
                  'Inloggen',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextButton(
                  onPressed: () => context.go('/register'),
                  child: const Text('Nog geen account?'),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'Gebruikersnaam'),
                        onSaved: (value) {
                          username = value!; // Save the entered email
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Wachtwoord'),
                        onSaved: (value) {
                          password = value!; // Save the entered email
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: () async {
                            await submitForm();
                          },
                          child: const Text('Inloggen'),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}