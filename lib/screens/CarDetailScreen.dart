import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/RentalController.dart';
import '../DependencyInjection.dart';
import '../models/CarModel.dart';
import '../widgets/CarDetailCard.dart';

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
  bool userLocationLoaded = false;

  @override
  void initState() {
    super.initState();
    setUserLocation();
  }

  // TODO: move when re-used
  // TODO: location could be fixed in search screen, and should be stored to prevent constant access
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
      userLocationLoaded = true; // Mark as loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _rentalController.getCar(widget.carId),
      builder: (BuildContext context, AsyncSnapshot<CarModel?> snapshot) {
        if (snapshot.hasData) {
          final car = snapshot.data;
          var carLocation = LatLng(car!.latitude, car.longitude);

          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/home'),
                  color: const Color(0xFF6F82F8),
                ),
              ),
              body: !userLocationLoaded
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: FlutterMap(
                                options: MapOptions(
                                  initialCenter: carLocation,
                                  initialZoom: 16,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                                        pattern: StrokePattern.dashed(
                                            segments: const [20, 20]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: CarDetailCard(
                                    car: car, userLocation: userLocation),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 50,
                          left: MediaQuery.of(context).size.width / 2 - 28,
                          child: FloatingActionButton(
                            child: const Text('Huren'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        const Text('Kies start- en einddatum'),
                                    content: Column(
                                      children: [
                                        FloatingActionButton(
                                          child:
                                              const Text("Startdatum kiezen"),
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
                                        child: const Text('Huren'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ));
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
