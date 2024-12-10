import 'package:flutter/material.dart';

class FormHelper {
  static Widget buildTextField(String label, Function(String?) onSaved,
      {bool obscureText = false}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      obscureText: obscureText,
      onSaved: onSaved,
    );
  }
}
