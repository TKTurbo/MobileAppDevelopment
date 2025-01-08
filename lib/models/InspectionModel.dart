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

  static InspectionModel fromJson(Map<String, dynamic> json) {
    return InspectionModel(
      id: json['id'],
      code: json['code'],
      odometer: json['odometer'],
      result: json['result'],
      description: json['description'],
      photo: json['photo'],
      photoContentType: json['photoContentType'],
      completed:
          json['completed'] != null ? DateTime.parse(json['completed']) : null,
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
    });
  }
}
