import 'dart:convert';
import 'dart:io';

import 'package:mobile_app_development/extensions/HttpResponseExtension.dart';
import 'package:mobile_app_development/services/api/ApiService.dart';

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

  Future<List<InspectionModel>> getInspections(int rentalId) async {
    final response = await apiService.getInspections(rentalId);
    var data = json.decode(response.body);

    var inspections = (data as List)
        .map((item) => InspectionModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return inspections;
  }
}
