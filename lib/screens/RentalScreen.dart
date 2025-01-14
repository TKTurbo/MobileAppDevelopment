import 'package:flutter/material.dart';
import '../controllers/RentalController.dart';
import '../DependencyInjection.dart';
import '../models/RentalModel.dart';
import '../widgets/MainBottomNavigation.dart';
import '../widgets/RentalListCard.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RentalController rentalController =
        DependencyInjection.getIt.get<RentalController>();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            const Center(
              child: const Text(
                "Uw boekingen",
                style: TextStyle(fontSize: 50, color: Color(0xFFFFFFFF)),
              ),
            ),
            FutureBuilder(
                future: rentalController.getActiveRentals(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<RentalModel>> snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<RentalModel>? rentals = snapshot.data;
                    return Expanded(
                        child: ListView.builder(
                      itemCount: rentals!.length,
                      itemBuilder: (context, index) {
                        final rental = rentals[index];
                        return RentalListCard(rental: rental);
                      },
                    ));
                  } else {
                    return const Text("Geen boekingen gevonden");
                  }
                }),
          ],
        ),
      ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 1,
      ),
    );
  }
}
