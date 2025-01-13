import 'dart:convert';

import 'package:mobile_app_development/models/RentalModel.dart';

class CustomerModel {
  int id;
  int? nr;
  String lastName;
  String firstName;
  String? from;
  dynamic systemUser;
  List<RentalModel> rentals;

  CustomerModel(
      {required this.id,
      required this.nr,
      required this.lastName,
      required this.firstName,
      required this.from,
      required this.systemUser,
      required this.rentals});

  String toJson() {
    return jsonEncode({
      'id': id,
      'nr': nr,
      'firstName': lastName,
      'lastName': firstName,
      'from': from,
      'systemUser': systemUser,
      'rentals': rentals,
    });
  }

  // TODO: moet overal Map<String, dynamic> zijn
  static CustomerModel fromJson(Map<String, dynamic> data) {
    return CustomerModel(
        id: data['id'],
        nr: data['nr'],
        lastName: data['lastName'],
        firstName: data['firstName'],
        from: data['from'],
        systemUser: data['systemUser'],
        rentals: data['rentals'] != null ? rentalListFromJson(data['rentals']) : []
    );
  }

  static List<RentalModel> rentalListFromJson(List<dynamic> data) {
    return List<RentalModel>.from(
        data.map((model) => RentalModel.fromJson(model))
    );
  }
}
