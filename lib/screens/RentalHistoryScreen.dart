import 'package:flutter/material.dart';

import '../DependencyInjection.dart';
import '../controllers/RentalController.dart';
import '../models/RentalModel.dart';
import '../widgets/MainBottomNavigation.dart';
import '../widgets/RentalListCard.dart';

class RentalHistoryScreen extends StatefulWidget {
  const RentalHistoryScreen({super.key});

  @override
  RentalHistoryState createState() => RentalHistoryState();
}

class RentalHistoryState extends State<RentalHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    RentalController rentalController =
        DependencyInjection.getIt.get<RentalController>();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        child: Column(children: [
          const Text(
            "Uw huurgeschiedenis",
            style: TextStyle(fontSize: 40, color: Color(0xFFFFFFFF)),
          ),
          FutureBuilder(
              future: rentalController.getRentals(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<RentalModel>> snapshot) {
                if (snapshot.hasData) {
                  final rentals = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: rentals!.length,
                        itemBuilder: (context, index) {
                          final rental = rentals[index];
                          return RentalListCard(rental: rental);
                        }),
                  );
                } else {
                  return const Text("Geen boekingen gevonden");
                }
              })
        ]),
      ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 2,
      ),
    );
  }
}
