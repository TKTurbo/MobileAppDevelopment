import 'dart:convert';

import 'package:mobile_app_development/services/ApiService.dart';
import '../DependencyInjection.dart';
import '../models/InspectionModel.dart';
import '../models/LoginModel.dart';
import '../services/AuthService.dart';

class InspectionController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

  Future<bool> addInspection(InspectionModel inspectionModel) async {
    final response = await apiService.addInspection(inspectionModel);

    print(response.body);

    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
