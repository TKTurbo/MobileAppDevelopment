import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/controllers/AccountController.dart';
import 'package:mobile_app_development/models/AccountInfoModel.dart';

import '../DependencyInjection.dart';
import '../helpers/FormHelper.dart';
import '../helpers/RouteHelper.dart';
import '../services/AuthService.dart';
import '../widgets/MainBottomNavigation.dart';

class ChangeAccountInfoScreen extends StatefulWidget {
  const ChangeAccountInfoScreen({super.key});

  @override
  ChangeAccountInfoState createState() => ChangeAccountInfoState();
}

class ChangeAccountInfoState extends State<ChangeAccountInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AccountController _controller =
      DependencyInjection.getIt.get<AccountController>();
  late AccountInfoModel _accountInfoModel;
  final AuthService _authService = DependencyInjection.getIt.get<AuthService>();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAccountInfo();
  }

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
                  'Account info wijzigen',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            FormHelper.buildTextField('Voornaam', (value) {
                              _accountInfoModel.firstName = value!;
                            }, initialValue: _accountInfoModel.firstName),
                            FormHelper.buildTextField('Achternaam', (value) {
                              _accountInfoModel.lastName = value!;
                            }, initialValue: _accountInfoModel.lastName),
                            FormHelper.buildTextField('E-mailadres', (value) {
                              _accountInfoModel.email = value!;
                            }, initialValue: _accountInfoModel.email),
                            FormHelper.buildTextField('Taal', (value) {
                              _accountInfoModel.langKey = value!;
                            }, initialValue: _accountInfoModel.langKey),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: ElevatedButton(
                                onPressed: () => _handleSubmit(context),
                                child: const Text('Accountinfo wijzigen'),
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

    bool isSuccess = await _controller.changeAccountInfo(_accountInfoModel);

    if (isSuccess) {
      RouteHelper.showSnackBarAndNavigate(
          context, 'Accountinfo gewijzigd', '/account');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kon accountinfo niet wijzigen')),
      );
    }
  }

  Future<void> _fetchAccountInfo() async {
    _accountInfoModel = await _controller.getAccountInfo();
    setState(() {
      _isLoading = false;
    });
  }
}
