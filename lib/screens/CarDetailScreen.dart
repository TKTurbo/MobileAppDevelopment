import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/RentalController.dart';
import '../DependencyInjection.dart';
import '../models/CarModel.dart';

class CarDetailsScreen extends StatefulWidget {
  final int carId;

  const CarDetailsScreen({super.key, required this.carId});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  final RentalController _rentalController =
      DependencyInjection.getIt.get<RentalController>();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  late LatLng userLocation;
  bool locationLoaded = false;

  @override
  void initState() {
    super.initState();
    setUserLocation();
  }

  // TODO: move when re-used
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> setUserLocation() async {
    Position position = await determinePosition();

    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
      locationLoaded = true;  // Mark as loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _rentalController.getCar(widget.carId),
      builder: (BuildContext context, AsyncSnapshot<CarModel?> snapshot) {
        if (snapshot.hasData) {
          final car = snapshot.data;
          var imageBlob = car?.picture;
          var image = Base64Codec().decode(imageBlob!);
          var carLocation = LatLng(car!.latitude, car.longitude);

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => context.go('/home'),
                color: const Color(0xFF6F82F8),
              ),
            ),
            body: Column(
              children: [
                // FlutterMap widget
                SizedBox(
                  height: 250, // Adjust the height as needed
                  child: !locationLoaded ? const Center(child: CircularProgressIndicator()) : FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(car!.latitude, car.longitude),
                      initialZoom: 16,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: carLocation,
                            width: 50,
                            height: 50,
                            child: GestureDetector(
                              child: const Icon(
                                Icons.car_rental,
                                color: Color(0xFF6F82F8),
                                size: 50.0,
                              ),
                            ),
                          ),
                          Marker(
                            point: userLocation,
                            width: 50,
                            height: 50,
                            child: const Icon(
                              Icons.person,
                              color: Colors.red,
                              size: 50.0,
                            ),
                          ),
                        ],
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: [
                              userLocation,
                              carLocation,
                            ],
                            strokeWidth: 4.0,
                            color: Colors.black,
                            pattern: StrokePattern.dashed(segments: const [20, 20]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Card(
                      child: SizedBox(
                        height: 450,
                        width: 370,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${car!.brand} ${car.model}",
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(
                              width: 300,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.memory(image),
                              ),
                            ),
                            Text(
                              "Kenteken: ${car.licensePlate}\n"
                              "Type brandstof: ${car.fuel}\n",
                            ),
                            FloatingActionButton(
                              child: Text('Huren'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Kies start- en einddatum'),
                                      content: Column(
                                        children: [
                                          FloatingActionButton(
                                            child: const Text("Startdatum kiezen"),
                                            onPressed: () => _selectStartDate(),
                                          ),
                                          FloatingActionButton(
                                            child: const Text("Einddatum kiezen"),
                                            onPressed: () => _selectEndDate(),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('Annuleren'),
                                        ),
                                        TextButton(
                                          onPressed: () => _confirmRental(
                                            car,
                                            selectedStartDate,
                                            selectedEndDate,
                                          ),
                                          child: Text('Huren'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          print(snapshot.error);
          return Scaffold(body: Text('Fout bij het laden van de auto'));
        }
      },
    );
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2101));
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  _confirmRental(CarModel car, DateTime startDate, DateTime endDate) async {
    var successfullyRented =
        await _rentalController.rentCar(car, startDate, endDate);
    if (successfullyRented) {
      context.go('/rentals');
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
