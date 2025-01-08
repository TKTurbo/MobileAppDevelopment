import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_app_development/helpers/LocationHelper.dart';

import '../models/CarModel.dart';

class CarListCard extends StatelessWidget {
  final CarModel car;
  final LatLng userLocation;

  const CarListCard(
      {super.key, required CarModel this.car, required this.userLocation});

  @override
  Widget build(BuildContext context) {
    var imageBlob = car.picture;
    var image = const Base64Codec().decode(imageBlob);
    var distance =
        LocationHelper.calculateDistance(userLocation, car.getLatLng());

    return Container(
      margin: const EdgeInsets.only(top: 1),
      child: GestureDetector(
        onTap: () => context.goNamed('car_details',
            pathParameters: {'carId': car.id.toString()}),
        child: Card(
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 5, left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${car.brand} ${car.model}",
                              style: const TextStyle(fontSize: 25),
                            ),
                            Text(
                              "€ ${car.price} | $distance km hier vandaan",
                              style: const TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.memory(image),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
