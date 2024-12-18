import 'package:flutter/material.dart';

import '../DependencyInjection.dart';
import '../controllers/RentalController.dart';
import '../models/RentalModel.dart';

class RentalHistoryScreen extends StatefulWidget {
  const RentalHistoryScreen({super.key});

  @override
  RentalHistoryState createState() => RentalHistoryState();
}

class RentalHistoryState extends State<RentalHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    RentalController _rentalController = DependencyInjection.getIt.get<RentalController>();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
          const Text(
            "Uw huurgeschiedenis",
            style: TextStyle(fontSize: 40, color: Color(0xFFFFFFFF)),
          ),
            FutureBuilder(future: _rentalController.getRentals(), builder: (BuildContext context, AsyncSnapshot<List<RentalModel>> snapshot) {
              if (snapshot.hasData) {
                final rentals = snapshot.data;
                return Expanded(
                    child: ListView.builder(
                      itemCount: rentals!.length,
                        itemBuilder: (context, index) {
                      final rental = rentals[index];
                      return Card(
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
                                      style: const TextStyle(
                                          fontSize: 25),
                                    ),
                                    Text(
                                      "Van: ${rental.fromDate}",
                                      style: const TextStyle(
                                          fontSize: 25),
                                    ),
                                    Text(
                                      "Tot: ${rental.toDate}",
                                      style: const TextStyle(
                                          fontSize: 25),
                                    ),
                                                                ],
                                                              )
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                );
              } else {
                return Text("Geen boekingen gevonden");
              }
            })
        ]
        ),
      ),
    );
  }
}