import 'dart:convert';
import 'dart:developer';

import 'package:mobile_app_development/services/ApiService.dart';
import '../DependencyInjection.dart';
import '../models/InspectionModel.dart';
import '../models/sendonly/LoginModel.dart';
import '../services/AuthService.dart';

class InspectionController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

  Future<bool> addInspection(InspectionModel inspectionModel) async {
    print(inspectionModel.code);
    print(inspectionModel.completed);
    print(inspectionModel.description);
    print(inspectionModel.id);
    print(inspectionModel.odometer);
    print(inspectionModel.photo);
    print(inspectionModel.photoContentType);
    print(inspectionModel.result);

    final response = await apiService.addInspection(inspectionModel);

    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
