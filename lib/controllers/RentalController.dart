import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mobile_app_development/models/CustomerModel.dart';
import 'package:mobile_app_development/models/RentalModel.dart';
import 'package:uuid/uuid.dart';
import '../DependencyInjection.dart';
import '../models/CarModel.dart';
import '../services/ApiService.dart';
import '../services/NotificationService.dart';

class RentalController {
  final ApiService apiService = DependencyInjection.getIt.get<ApiService>();
  final NotificationService notificationService =
      DependencyInjection.getIt.get<NotificationService>();

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
      code: const Uuid().v4(),
      longitude: car.longitude,
      latitude: car.latitude,
      fromDate: formatter.format(from),
      toDate: formatter.format(to),
      state: "RESERVED",
      inspections: null,
      customer: customer.toJson(),
      car: car,
    );

    var response = await apiService.rentCar(rental);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      notificationService.scheduleReturnReminder(to, car);
      return true;
    }

    return false;
  }

  Future<List<RentalModel>> getRentals() async {
    final response = await apiService.getCurrentCustomer();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseBody = json.decode(response.body);

      CustomerModel customer = CustomerModel.fromJson(responseBody);

      List<RentalModel> customerRentals = [];
      if (customer.rentals != null) {
        for (var i = 0; i < customer.rentals.length; i++) {
          RentalModel rental = RentalModel.fromJson(customer.rentals[i]);
          customerRentals.add(rental);
        }
      }

      return customerRentals;
    }

    return [];
  }

  Future<List<RentalModel>> getActiveRentals() async {
    final response = await apiService.getCurrentCustomer();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseBody = json.decode(response.body);

      CustomerModel customer = CustomerModel.fromJson(responseBody);

      List<RentalModel> customerRentals = [];
      if (customer.rentals != null) {
        for (var i = 0; i < customer.rentals.length; i++) {
          if (customer.rentals[i]['state'] == 'RESERVED' ||
              customer.rentals[i]['state'] == 'ACTIVE') {
            RentalModel rental = RentalModel.fromJson(customer.rentals[i]);
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
