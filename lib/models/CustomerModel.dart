import 'dart:convert';

class CustomerModel {
  int id;
  int? nr;
  String lastName;
  String firstName;
  String? from;
  dynamic systemUser;
  dynamic rentals;

  CustomerModel({
    required this.id,
    required this.nr,
    required this.lastName,
    required this.firstName,
    required this.from,
    required this.systemUser,
    required this.rentals
  });

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

  static CustomerModel fromJson(data) {
    return CustomerModel(
        id: data['id'],
        nr: data['nr'],
        lastName: data['lastName'],
        firstName: data['firstName'],
        from: data['from'],
        systemUser: data['systemUser'],
        rentals: data['rentals']);
  }
}