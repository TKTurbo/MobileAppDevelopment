import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/rentalcontroller.dart';
import '../models/carmodel.dart';

class CarDetailsScreen extends StatefulWidget {
  final dynamic carId;
  const CarDetailsScreen({super.key, required this.carId});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  final RentalController _rentalController = RentalController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _rentalController.getCar(widget.carId),
        builder: (BuildContext context, AsyncSnapshot<CarModel?> snapshot) {
          if (snapshot.hasData) {
            final car = snapshot.data;
            return Scaffold(
                body: Center(
              child: Container(
                  child: Card(
                      child: SizedBox(
                          height: 800,
                          width: 370,
                          child: Column(
                            children: [
                              Text(car!.brand + " " + car.model),
                              FloatingActionButton(
                                  child: Text('Huren'),
                                  onPressed: () => {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Kies start- en einddatum'),
                                            content: Column(
                                              children: [
                                                FloatingActionButton(
                                                  child: Text("Startdatum kiezen"),
                                                    onPressed: () => _selectStartDate(),
                                                ),
                                                FloatingActionButton(
                                                  child: Text("Einddatum kiezen"),
                                                  onPressed: () => _selectEndDate(),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => Navigator.of(context).pop(),
                                                  child: Text('Annuleren')
                                              ),
                                              TextButton(
                                                  onPressed: () => _confirmRental(car, selectedStartDate, selectedEndDate),
                                                  child: Text('Huren')
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                  }
                              )
                            ],
                          )))),
            ));
          } else {
            print(snapshot.error);
            return Scaffold(body: Text('Fout bij het laden van de auto'));
          }
        });
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
      if (picked != null && picked != selectedStartDate) {
        setState(() {
          selectedStartDate = picked;
        });
      }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  _confirmRental(CarModel car, DateTime startDate, DateTime endDate) async {
    var successfullyRented = await _rentalController.rentCar(car, startDate, endDate);
    if (successfullyRented) {
      context.go('/home');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Huren gelukt')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fout bij het huren')),
      );
    }
    Navigator.of(context).pop();
  }
}

