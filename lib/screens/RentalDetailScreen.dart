import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/RentalController.dart';
import '../DependencyInjection.dart';
import '../models/RentalModel.dart';

class RentalDetailScreen extends StatefulWidget {
  final int rentalId;

  const RentalDetailScreen({super.key, required this.rentalId});

  @override
  State<RentalDetailScreen> createState() => _RentalDetailScreenState();
}

class _RentalDetailScreenState extends State<RentalDetailScreen> {
  final RentalController _rentalController =
      DependencyInjection.getIt.get<RentalController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _rentalController.getRental(widget.rentalId),
        builder: (BuildContext context, AsyncSnapshot<RentalModel?> snapshot) {
          if (snapshot.hasData) {
            final rental = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Rental Details'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/rentals'),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${rental?.car['brand']} ${rental?.car['model']} ${rental?.car['licensePlate']}\n",
                      style: const TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    Text(
                      "Kenmerk: ${rental?.code}\n",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          context.go('/create_inspection/${rental?.id}'),
                      child: const Text('Melding maken'),
                    ),
                    ElevatedButton(
                      onPressed: () => print('todo'), // TODO: show inspections
                      child: const Text('Bekijk meldingen'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
                body: Text('Fout bij het laden van de boeking'));
          }
        });
  }
}
