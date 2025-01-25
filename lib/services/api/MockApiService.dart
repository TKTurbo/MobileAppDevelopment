import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_app_development/models/RentalModel.dart';

import 'IApiService.dart';

class MockApiService extends IApiService {
  @override
  changeRental(RentalModel rental) {
    // TODO: implement changeRental
    throw UnimplementedError();
  }

  @override
  getAllCars() {
    // TODO: implement getAllCars
    throw UnimplementedError();
  }

  @override
  getCar(int id) {
    // TODO: implement getCar
    throw UnimplementedError();
  }

  @override
  getCurrentCustomer() {
    final formatter = DateFormat("yyyy-MM-dd");
    Map<String, dynamic> data = {
      "id": 0,
      "nr": 0,
      "firstName": "Unit",
      "lastName": "Test",
      "from": formatter.format(DateTime.now()),
      "systemUser": [],
      "rentals": [],
    };

    return json.encode(data);
  }

  @override
  getRental(int id) {

  }

  @override
  removeRental(int rentalId) {
    // TODO: implement removeRental
    throw UnimplementedError();
  }

  @override
  bool rentCar(RentalModel rental) {
    return true;
  }

}