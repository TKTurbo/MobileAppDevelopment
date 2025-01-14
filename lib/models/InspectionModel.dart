import 'dart:convert';

class InspectionModel {
  int id;
  String code;
  int odometer;
  String result;
  String description;
  String photo;
  String photoContentType;
  DateTime? completed;
  int? rentalId;

  InspectionModel({
    required this.id,
    required this.code,
    required this.odometer,
    required this.result,
    required this.description,
    required this.photo,
    required this.photoContentType,
    DateTime? completed,
  });

  static InspectionModel fromJson(Map<String, dynamic> data) {
    return InspectionModel(
      id: data['id'],
      code: data['code'],
      odometer: data['odometer'],
      result: data['result'],
      description: data['description'],
      photo: data['photo'],
      photoContentType: data['photoContentType'],
      completed:
          data['completed'] != null ? DateTime.parse(data['completed']) : null,
    );
  }

  String toJson() {
    return jsonEncode({
      'code': code,
      'odometer': odometer,
      'result': result,
      'description': description,
      'photo': photo,
      'photoContentType': photoContentType,
      'completed': completed?.toIso8601String(),
      'rental': {'id': rentalId}
    });
  }
}
