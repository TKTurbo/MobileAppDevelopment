import 'dart:convert';

import 'package:mobile_app_development/models/rentalmodel.dart';
import 'package:uuid/uuid.dart';

import '../models/carmodel.dart';
import '../models/customermodel.dart';
import '../services/apiservice.dart';

class RentalController {
  final ApiService apiService = ApiService();

  Future<List<CarModel>> getAllCars() async {
    final response = await apiService.getAllCars();
    if (response.statusCode == 200) {
      final carListJson = json.decode(response.body);
      List<CarModel> carList = [];

      for (var i = 0; i < carListJson.length; i++) {
        final car = CarModel.fromJson(carListJson[i]);
        carList.add(car);
      }

      return carList;
    }

    return [];
  }

  Future<CarModel?> getCar(id) async {
    final response = await apiService.getCar(id);

    if (response.statusCode == 200) {
      final carJson = json.decode(response.body);
      final car = CarModel.fromJson(carJson);
      return car;
    }

    return null;
  }

  Future<bool> rentCar(CarModel car, DateTime from, DateTime to) async {
    //TODO call api to rent car
    return false;
  }

  Future<List<RentalModel>?> getRentals() async {
    final response = await apiService.getCurrentCustomer();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //TODO return customer's rentals
    }


    return null;
  }
}