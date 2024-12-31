import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/LoginController.dart';
import '../DependencyInjection.dart';
import '../helpers/FormHelper.dart';
import '../models/LoginModel.dart';

class CreateInspectionScreen extends StatefulWidget {
  const CreateInspectionScreen({super.key});

  @override
  CreateInspectionScreenState createState() => CreateInspectionScreenState();
}

class CreateInspectionScreenState extends State<CreateInspectionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _controller =
      DependencyInjection.getIt.get<LoginController>();
  final LoginModel _loginModel = LoginModel(username: '', password: '');

  late File _image;

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
                  'Melding maken',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormHelper.buildTextField('Bericht', (value) {
                        _loginModel.username =
                            value!; // You can store the message here or use a different model
                      }),
                      SizedBox(height: 16),
                      _image == null
                          ? Text("No image selected.")
                          : Image.file(_image!),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Capture Image'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: () => _handleSubmit(context),
                          child: const Text('Melding maken'),
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

    var imageBytes = await _image.readAsBytes();
    var base64Image = base64Encode(imageBytes);

    print(222);
    print(base64Image);
    print(333);

    const SnackBar(content: Text('Melding gemaakt'));
  }

  _navigateIfLoggedIn() async {
    var loggedIn = await _controller.isLoggedIn();

    if (loggedIn) {
      context.go('/home');
    }
  }

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemperory = File(image.path);
      setState(() => _image = imageTemperory);
    } on PlatformException catch (e) {
      print(" File not Picked ");
    }
  }
}
