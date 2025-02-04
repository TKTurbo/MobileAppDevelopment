import 'dart:convert';

import 'package:latlong2/latlong.dart';

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
  double price;
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
    required this.price,
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
      'price': price,
      'body': body,
      'longitude': longitude,
      'latitude': latitude,
    });
  }

  static fromJson(Map<String, dynamic> data) {
    return CarModel(
        id: data['id'],
        brand: data['brand'],
        model: data['model'],
        picture: data['picture'],
        fuel: data['fuel'],
        options: data['options'],
        licensePlate: data['licensePlate'],
        engineSize: data['engineSize'],
        modelYear: data['modelYear'],
        since: data['since'],
        price: data['price'],
        body: data['body'],
        longitude: data['longitude'],
        latitude: data['latitude']);
  }

  LatLng getLatLng() {
    return LatLng(latitude, longitude);
  }
}
