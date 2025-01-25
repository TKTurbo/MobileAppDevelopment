import 'package:mobile_app_development/models/RentalModel.dart';

abstract class IApiService {
  getAllCars();

  getCar(int id);

  getCurrentCustomer();

  rentCar(RentalModel rental);

  getRental(int id);

  removeRental(int rentalId);

  changeRental(RentalModel rental);

}