import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../controllers/RentalController.dart';
import '../DependencyInjection.dart';
import '../models/RentalModel.dart';
import '../services/NotificationService.dart';
import '../widgets/mainbottomnavigation.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RentalController _rentalController = DependencyInjection.getIt.get<RentalController>();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 80),
        child: Column(
          children: [
            const Text(
              "Uw boekingen",
              style: TextStyle(fontSize: 50, color: Color(0xFFFFFFFF)),
            ),
            FutureBuilder(
                future: _rentalController.getActiveRentals(),
                builder: (BuildContext context, AsyncSnapshot<List<RentalModel>> snapshot) {
                  if (snapshot.hasData) {
                    List<RentalModel>? rentals = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: rentals!.length,
                          itemBuilder: (context, index) {
                          final rental = rentals[index];
                            return GestureDetector(
                              onTap: () => context.goNamed('rental_details', pathParameters: {'rentalId': rental.id.toString()}),
                              child: Card(
                                child: SizedBox(
                                  height: 200,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Column(
                                          children: [
                                            Container(
                                                alignment:
                                                Alignment.centerLeft,
                                                margin:
                                                const EdgeInsets.only(
                                                  top: 5,
                                                  left: 5,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      rental.code,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                    Text(
                                                      "Van: ${rental.fromDate}",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                    Text(
                                                      "Tot: ${rental.toDate}",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          // child: Image.memory(image),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  } else {
                    return Text("Geen boekingen gevonden");
                  }
                }
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 1,
      ),
    );
  }



}