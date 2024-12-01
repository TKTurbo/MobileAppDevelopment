import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/services/apiservice.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ApiService apiService = ApiService();
    String username = '';
    String firstname = '';
    String lastname = '';
    String email = '';
    String langkey = '';
    String password = '';

    Future<void> submitForm() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save(); // Save the form data

        var response = await apiService.register(username, firstname, lastname, email, langkey, password);

        if (response.statusCode == 200) {
          context.go('/login'); // werkt nog niet? andere status code ofzo?
        } else {
          // er ging iets mis
        }

        print(response.body);
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
                  'Registreren',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Al een account?'),
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
                        decoration: const InputDecoration(labelText: 'Voornaam'),
                        onSaved: (value) {
                          firstname = value!; // Save the entered email
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Achternaam'),
                        onSaved: (value) {
                          lastname = value!; // Save the entered email
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'E-mailadres'),
                        onSaved: (value) {
                          email = value!; // Save the entered email
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Taal'),
                        onSaved: (value) {
                          langkey = value!; // Save the entered email
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
                          child: const Text('Registreren'),
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