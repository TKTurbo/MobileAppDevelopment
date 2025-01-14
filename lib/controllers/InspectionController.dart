import 'dart:convert';
import 'dart:io';

import 'package:mobile_app_development/controllers/HttpResponseExtension.dart';
import 'package:mobile_app_development/services/ApiService.dart';

import '../DependencyInjection.dart';
import '../models/InspectionModel.dart';

class InspectionController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

  Future<bool> addInspection(
      InspectionModel inspectionModel, File? image, int rentalId) async {
    if (image != null) {
      List<int> bytes = image.readAsBytesSync() as List<int>;
      String base64Image = base64Encode(bytes);
      inspectionModel.photo = base64Image;
    }

    inspectionModel.rentalId = rentalId;

    final response = await apiService.addInspection(inspectionModel);

    return response.isSuccessful();
  }
}
