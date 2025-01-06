import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../controllers/RegisterController.dart';
import '../DependencyInjection.dart';
import '../helpers/FormHelper.dart';
import '../models/sendonly/RegisterModel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterController _controller = DependencyInjection.getIt.get<RegisterController>();

  final RegisterModel _registerModel = RegisterModel(
    username: '',
    firstname: '',
    lastname: '',
    email: '',
    langkey: '',
    password: '',
  );

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
                  'Registreren',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Al een account?'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormHelper.buildTextField('Gebruikersnaam', (value) {
                        _registerModel.username = value!;
                      }),
                      FormHelper.buildTextField('Voornaam', (value) {
                        _registerModel.firstname = value!;
                      }),
                      FormHelper.buildTextField('Achternaam', (value) {
                        _registerModel.lastname = value!;
                      }),
                      FormHelper.buildTextField('E-mailadres', (value) {
                        _registerModel.email = value!;
                      }),
                      FormHelper.buildTextField('Taal', (value) {
                        _registerModel.langkey = value!;
                      }),
                      FormHelper.buildTextField('Wachtwoord', (value) {
                        _registerModel.password = value!;
                      }, obscureText: true),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: () => _handleSubmit(context),
                          child: const Text('Registreren'),
                        ),
                      ),
                    ],
                  ),
                ),
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

    var registerSuccess = await _controller.register(_registerModel);

    if (registerSuccess) {
      context.go('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registratie mislukt')),
      );
    }
  }
}
