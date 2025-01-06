import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_app_development/helpers/LocationHelper.dart';
import 'package:mobile_app_development/models/CarModel.dart';

class CarDetailCard extends StatelessWidget {
  final CarModel car;

  final LatLng? userLocation;

  const CarDetailCard(
      {super.key, required this.car, this.userLocation});

  @override
  Widget build(BuildContext context) {
    var imageBlob = car.picture;
    var image = const Base64Codec().decode(imageBlob);

    var distanceFromCar =
        LocationHelper.calculateDistance(userLocation!, car.getLatLng());

    return Card(
      child: SizedBox(
        height: 350,
        width: 370,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${car!.brand} ${car.model}",
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "$distanceFromCar km van mij vandaan",
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 300,
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.memory(image),
              ),
            ),
            Text("Kenteken: ${car.licensePlate}\n"
                "Type brandstof: ${car.fuel}\n"),
          ],
        ),
      ),
    );
  }
}
