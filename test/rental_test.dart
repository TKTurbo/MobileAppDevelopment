import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_development/controllers/RentalController.dart';
import 'package:mobile_app_development/models/CarModel.dart';

void main () async {
  test('Given car, start and enddate are valid when rentCar is called then return true', () {
    RentalController rentalController = RentalController();

    Map<String, dynamic> carJson = {
      "id": 1,
      "brand": '',
      "model": '',
      "picture": '',
      "options": [],
      "licensePlate": '',
      "engineSize": 0,
      "modelYear": 0,
      "since": '',
      "price": 0.0,
      "body": '',
      "longitude": 0,
      "latitude": 0,
    };
    CarModel car = CarModel.fromJson(carJson);
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(const Duration(days: 2));

    expect(rentalController.rentCar(car, startDate, endDate), true);
  });

  test('Given end date is before start date when rentCar is called then return false', () {
    RentalController rentalController = RentalController();

    Map<String, dynamic> carJson = {
      "id": 1,
      "brand": '',
      "model": '',
      "picture": '',
      "options": [],
      "licensePlate": '',
      "engineSize": 0,
      "modelYear": 0,
      "since": '',
      "price": 0.0,
      "body": '',
      "longitude": 0,
      "latitude": 0,
    };
    CarModel car = CarModel.fromJson(carJson);
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().subtract(const Duration(days: 2));

    expect(rentalController.rentCar(car, startDate, endDate), false);
  });

  test('Given end date and start date have passed when rentCar is called then return false', () {
    RentalController rentalController = RentalController();

    Map<String, dynamic> carJson = {
      "id": 1,
      "brand": '',
      "model": '',
      "picture": '',
      "options": [],
      "licensePlate": '',
      "engineSize": 0,
      "modelYear": 0,
      "since": '',
      "price": 0.0,
      "body": '',
      "longitude": 0,
      "latitude": 0,
    };
    CarModel car = CarModel.fromJson(carJson);
    DateTime startDate = DateTime.now().subtract(const Duration(days: 3));
    DateTime endDate = DateTime.now().subtract(const Duration(days: 2));

    expect(rentalController.rentCar(car, startDate, endDate), false);
  });
}