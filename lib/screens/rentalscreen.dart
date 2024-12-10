import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/rentalcontroller.dart';
import '../dependencyinjection.dart';
import '../models/rentalmodel.dart';
import '../widgets/mainbottomnavigation.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RentalController _rentalController = DependencyInjection.getIt.get<RentalController>();
    return Scaffold(
      body: Column(
          children: [
            FutureBuilder(
                future: _rentalController.getRentals(),
                builder: (BuildContext context, AsyncSnapshot<List<RentalModel>?> snapshot) {
                  if (snapshot.hasData) {
                    List<RentalModel>? rentals = snapshot.data;
                    return Column(
                      children: [
                        ListView.builder(
                            itemCount: rentals?.length,
                            itemBuilder: (context, int index) {
                              return Card(
                                child: Text(rentals?[index].car.brand),
                              );
                            }
                        ),
                      ],
                    );
                  } else {
                    return Text("Geen boekingen gevonden");
                  }
                }
            )
          ]
        ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 1,
      ),
    );
  }



}