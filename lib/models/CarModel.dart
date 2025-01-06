import 'dart:convert';

class CarModel {
  int id;
  String brand;
  String model;
  String picture;
  String fuel;
  String options;
  String licensePlate;
  int engineSize;
  int modelYear;
  String since;
  String body;
  double longitude;
  double latitude;

  CarModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.picture,
    required this.fuel,
    required this.options,
    required this.licensePlate,
    required this.engineSize,
    required this.modelYear,
    required this.since,
    required this.body,
    required this.longitude,
    required this.latitude,
  });

  String toJson() {
    return jsonEncode({
      'id': id,
      'brand': brand,
      'model': model,
      'picture': picture,
      'fuel': fuel,
      'options': options,
      'licensePlate': licensePlate,
      'engineSize': engineSize,
      'modelYear': modelYear,
      'since': since,
      'body': body,
      'longitude': longitude,
      'latitude': latitude,
    });
  }

  static fromJson(car) {
    return CarModel(
      id: car['id'],
      brand: car['brand'],
      model: car['model'],
      picture: car['picture'],
      fuel: car['fuel'],
      options: car['options'],
      licensePlate: car['licensePlate'],
      engineSize: car['engineSize'],
      modelYear: car['modelYear'],
      since: car['since'],
      body: car['body'],
      longitude: car['longitude'],
      latitude: car['latitude']
    );
  }


}