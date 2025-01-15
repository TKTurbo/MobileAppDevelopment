import 'dart:convert';

import 'package:mobile_app_development/models/CarModel.dart';
import 'package:mobile_app_development/models/CustomerModel.dart';

class RentalModel {
  int? id;
  String code;
  double longitude;
  double latitude;
  String fromDate;
  String toDate;
  String state;

  dynamic inspections; // is always null, can be ignored
  CustomerModel? customer; // these two are not always filled
  CarModel? car;

  RentalModel({
    required this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.fromDate,
    required this.toDate,
    required this.state,
    required this.inspections,
    required this.customer,
    required this.car,
  });

  String toJson() {
    return jsonEncode({
      'id': id,
      'code': code,
      'longitude': longitude,
      'latitude': latitude,
      'fromDate': fromDate,
      'toDate': toDate,
      'state': state,
      'inspections': inspections,
      'customer': {'id': customer?.id},
      'car': {'id': car?.id},
    });
  }

  static fromJson(Map<String, dynamic> data) {
    return RentalModel(
      id: data['id'],
      code: data['code'],
      longitude: data['longitude'],
      latitude: data['latitude'],
      fromDate: data['fromDate'],
      toDate: data['toDate'],
      state: data['state'],
      inspections: data['inspections'], // nullable
      customer: data['customer'] != null ? CustomerModel.fromJson(data['customer']) : null,
      car: data['car'] != null ? CarModel.fromJson(data['car']) : null,
    );
  }
}
