import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_development/controllers/InspectionController.dart';
import 'package:mobile_app_development/models/InspectionModel.dart';
import '../DependencyInjection.dart';
import '../helpers/FormHelper.dart';

class CreateInspectionScreen extends StatefulWidget {
  const CreateInspectionScreen({super.key});

  @override
  CreateInspectionScreenState createState() => CreateInspectionScreenState();
}

class CreateInspectionScreenState extends State<CreateInspectionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InspectionController _controller =
      DependencyInjection.getIt.get<InspectionController>();
  final InspectionModel _inspectionModel = InspectionModel(id: 0, code: "", odometer: 0, result: "", description: "", photo: "", photoContentType: "");

  File? _image;

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
                        _inspectionModel.description =
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

    List<int> bytes = _image?.readAsBytesSync() as List<int>;
    //String base64Image =  "data:image/png;base64,${base64Encode(bytes)}";
    String base64Image =  base64Encode(bytes);

    try {
      // TODO: refactor
      _inspectionModel.photo = base64Image;

      _controller.addInspection(_inspectionModel);

      //context.go('/home');
      const SnackBar(content: Text('Melding gemaakt'));
    } catch(e) {
      const SnackBar(content: Text('Er ging iets mis'));
    }

  }

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemperory = File(image.path);
      setState(() => _image = imageTemperory);
    } on PlatformException catch (e) {
      print("File not Picked");
    }
  }
}
