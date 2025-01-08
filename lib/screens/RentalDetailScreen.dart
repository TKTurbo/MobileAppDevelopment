import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/RentalController.dart';
import '../DependencyInjection.dart';
import '../helpers/RouteHelper.dart';
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
                      "${rental?.car['brand']} ${rental?.car['model']} ${rental?.car['licensePlate']}",
                      style: const TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    Text(
                      "Status: ${rental?.state}\n",
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(
                      "Kenmerk: ${rental?.code}\n",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Bevestigen'),
                              content:
                                  Text('Weet u zeker dat u deze reservering wil annuleren?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Annuleren'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cancelReservation(context);
                                  },
                                  child: Text('Bevestigen'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Reservering annuleren'),
                    ),
                    const SizedBox(height: 16),
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

  Future<void> cancelReservation(BuildContext context) async {
    var isSuccess = await _rentalController.removeRental(widget.rentalId);

    if(isSuccess) {
      RouteHelper.showSnackBarAndNavigate(context, 'Reservering is geannuleerd', '/rentals');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reservering kon niet verwijderd worden. Zijn er actieve meldingen?')),
      );
      Navigator.of(context).pop();
    }
  }
}
