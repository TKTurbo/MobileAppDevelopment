import 'dart:convert';

class RentalModel {
  int? id;
  String code;
  double longitude;
  double latitude;
  String fromDate;
  String toDate;
  String state;
  // TODO: check if we can make the corresponding models for these
  dynamic inspections; // is always null, can be ignored
  dynamic customer;
  dynamic car;

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
//      'id': id,
      'code': code,
      'longitude': longitude,
      'latitude': latitude,
      'fromDate': fromDate,
      'toDate': toDate,
      'state': state,
      'inspections': inspections,
      'customer': json.decode(customer),
      'car': json.decode(car),
    });
  }

  static fromJson(rental) {
    return RentalModel(
      id: rental['id'],
      code: rental['code'],
      longitude: rental['longitude'],
      latitude: rental['latitude'],
      fromDate: rental['fromDate'],
      toDate: rental['toDate'],
      state: rental['state'],
      inspections: rental['inspections'],
      customer: rental['customer'],
      car: rental['car'],
    );
  }
}
