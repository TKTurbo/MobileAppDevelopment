import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _username = '';
    String _firstname = '';
    String _lastname = '';
    String _email = '';
    String _langkey = '';
    String _password = '';

    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save(); // Save the form data
        print('Name: $_username'); // Print the name
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('BlueWheels'),
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(32.0),
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Text(
                  'Registreren',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                        InputDecoration(labelText: 'Gebruikersnaam'),
                        onSaved: (value) {
                          _username = value!; // Save the entered email
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Voornaam'),
                        onSaved: (value) {
                          _firstname = value!; // Save the entered email
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Achternaam'),
                        onSaved: (value) {
                          _lastname = value!; // Save the entered email
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'E-mailadres'),
                        onSaved: (value) {
                          _email = value!; // Save the entered email
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Taal'),
                        onSaved: (value) {
                          _langkey = value!; // Save the entered email
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Wachtwoord'),
                        onSaved: (value) {
                          _password = value!; // Save the entered email
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: _submitForm,
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