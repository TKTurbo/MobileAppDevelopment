import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mobile_app_development/models/CustomerModel.dart';
import 'package:mobile_app_development/models/RentalModel.dart';
import 'package:uuid/uuid.dart';
import '../DependencyInjection.dart';
import '../models/CarModel.dart';
import '../services/ApiService.dart';

class RentalController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();

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

  Future<CarModel?> getCar(int id) async {
    final response = await apiService.getCar(id);

    if (response.statusCode == 200) {
      final carJson = json.decode(response.body);
      final car = CarModel.fromJson(carJson);
      return car;
    }

    return null;
  }

  Future<bool> rentCar(CarModel car, DateTime from, DateTime to) async {
    var getCustomer = await apiService.getCurrentCustomer();
    var customer = CustomerModel.fromJson(json.decode(getCustomer.body));

    final formatter = DateFormat("yyyy-MM-dd");
    final rental = RentalModel(
      id: null,
      code: Uuid().v4(),
      longitude: car.longitude,
      latitude: car.latitude,
      fromDate: formatter.format(from),
      toDate: formatter.format(to),
      state: "RESERVED",
      inspections: null,
      customer: customer.toJson(),
      car: car.toJson(),
    );

    var response = await apiService.rentCar(rental);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    }

    return false;
  }

  Future<List<RentalModel>> getRentals() async {
    //TODO hack. This should get the rentals via a customer
    final response = await apiService.getAllRentals();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var jsonBody = json.decode(response.body);

      final customerJson = await apiService.getCurrentCustomer();
      CustomerModel customer = CustomerModel.fromJson(json.decode(customerJson.body));

      List<RentalModel> customerRentals = [];
      for (var i = 0; i < jsonBody.length; i++) {
        if (jsonBody[i]['customer'] != null) {
          if (jsonBody[i]['customer']['id'] == customer.id) {
            RentalModel rental = RentalModel.fromJson(jsonBody[i]);
            customerRentals.add(rental);
          }
        }
      }
      return customerRentals;
    }

    return [];
  }

  Future<RentalModel?> getRental(int id) async {
    final response = await apiService.getRental(id);

    if (response.statusCode == 200) {
      final rentalJson = json.decode(response.body);
      final rental = RentalModel.fromJson(rentalJson);
      return rental;
    }

    return null;
  }
}
