import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/RentalController.dart';
import '../DependencyInjection.dart';
import '../helpers/LocationHelper.dart';
import '../helpers/RouteHelper.dart';
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

  Future<void> setUserLocation() async {
    Position position = await LocationHelper.determinePosition();

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
          var carLocation = car!.getLatLng();

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
                                    content: StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        print('reloadmeneer');
                                        print(selectedEndDate);
                                        return SizedBox(
                                          height: 100,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 300,
                                                child: Row(
                                                  children: [
                                                    const Text('Start:'),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Align(
                                                        alignment: Alignment.topRight,
                                                        child: TextFormField(
                                                          key: Key(selectedStartDate.toString()),
                                                          initialValue: "${selectedStartDate.day}-${selectedStartDate.month}-${selectedStartDate.year}",
                                                          decoration: const InputDecoration(
                                                              border: UnderlineInputBorder()
                                                          ),
                                                          onTap: () => setState(() => _selectStartDate()),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child: Row(
                                                  children: [
                                                    const Text('Eind:'),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: SizedBox(
                                                        width: 100,
                                                        child: TextFormField(
                                                          key: Key(selectedEndDate.toString()),
                                                          initialValue: "${selectedEndDate.day}-${selectedEndDate.month}-${selectedEndDate.year}",
                                                          decoration: const InputDecoration(
                                                              border: UnderlineInputBorder()
                                                          ),
                                                          onTap: () => setState(() => _selectEndDate()),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }

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
      RouteHelper.showSnackBarAndNavigate(context, 'Huren gelukt', '/rentals');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fout bij het huren')),
      );
    }
    Navigator.of(context).pop();
  }
}
