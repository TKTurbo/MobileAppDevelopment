import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/controllers/ChangePasswordController.dart';
import '../DependencyInjection.dart';
import '../helpers/FormHelper.dart';
import '../models/sendonly/ChangePasswordModel.dart';
import '../services/AuthService.dart';
import '../widgets/MainBottomNavigation.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ChangePasswordController _controller =
      DependencyInjection.getIt.get<ChangePasswordController>();
  final ChangePasswordModel _changePasswordModel =
      ChangePasswordModel(currentPassword: "", newPassword: "");
  final AuthService _authService = DependencyInjection.getIt.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.all(32.0),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Wachtwoord veranderen',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormHelper.buildTextField('Huidig wachtwoord', (value) {
                        _changePasswordModel.currentPassword = value!;
                      }, obscureText: true),
                      FormHelper.buildTextField('Nieuw wachtwoord', (value) {
                        _changePasswordModel.newPassword = value!;
                      }, obscureText: true),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: () => _handleSubmit(context),
                          child: const Text('Wachtwoord wijzigen'),
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
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 2,
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    bool isSuccess = await _controller.changePassword(_changePasswordModel);

    if (isSuccess) {
      _authService.clearToken();
      context.go('/login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Wachtwoord veranderd. Log A.u.b. opnieuw in.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Kon wachtwoord niet veranderen. Zorg dat het huidige wachtwoord klopt en het nieuwe wachtwoord voldoende lang is.')),
      );
    }
  }
}
