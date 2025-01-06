import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarListCard extends StatelessWidget {
  final dynamic car; // TODO: should not be dynamic

  const CarListCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    var imageBlob = car.picture;
    var image = const Base64Codec().decode(imageBlob);

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
                          children: [
                            Text(
                              "${car.brand} ${car.model}",
                              style: const TextStyle(fontSize: 25),
                            ),
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
