import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_development/controllers/InspectionController.dart';
import 'package:mobile_app_development/models/InspectionModel.dart';

import '../DependencyInjection.dart';
import '../helpers/FormHelper.dart';
import '../helpers/RouteHelper.dart';

class CreateInspectionScreen extends StatefulWidget {
  final int rentalId;

  const CreateInspectionScreen({super.key, required this.rentalId});

  @override
  CreateInspectionScreenState createState() => CreateInspectionScreenState();
}

class CreateInspectionScreenState extends State<CreateInspectionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InspectionController _controller =
      DependencyInjection.getIt.get<InspectionController>();
  final InspectionModel _inspectionModel = InspectionModel(
      id: 0,
      code: "",
      odometer: 0,
      result: "",
      description: "",
      photo: "",
      photoContentType: "",
      completed: null); // DateTime.now().toUtc());

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/rentals/${widget.rentalId}'),
          color: const Color(0xFF6F82F8),
        ),
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
                        _inspectionModel.description = value!;
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

    try {
      var isSuccess = await _controller.addInspection(
          _inspectionModel, _image, widget.rentalId);

      if (isSuccess) {
        RouteHelper.showSnackBarAndNavigate(
            context, 'Melding gemaakt', '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kon geen melding maken')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Er ging iets mis')),
      );
    }
  }

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => _image = imageTemporary);
    } on PlatformException {
      print("File not Picked");
    }
  }
}
