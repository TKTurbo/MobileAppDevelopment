import 'package:mobile_app_development/controllers/HttpResponseExtension.dart';
import 'package:mobile_app_development/services/ApiService.dart';
import '../DependencyInjection.dart';
import '../models/InspectionModel.dart';

class InspectionController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

  Future<bool> addInspection(InspectionModel inspectionModel) async {
    final response = await apiService.addInspection(inspectionModel);

    return response.isSuccessful();
  }
}
