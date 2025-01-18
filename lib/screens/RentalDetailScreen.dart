import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/helpers/LocationHelper.dart';

import '../DependencyInjection.dart';
import '../controllers/RentalController.dart';
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

  late RentalModel rental;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _rentalController.getRental(widget.rentalId),
        builder: (BuildContext context, AsyncSnapshot<RentalModel?> snapshot) {
          if (snapshot.hasData) {
            rental = snapshot.data!;
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
                      "${rental.car?.brand} ${rental.car?.model} ${rental.car?.licensePlate}",
                      style: const TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    Text(
                      "Status: ${rental.state}\n",
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(
                      "Kenmerk: ${rental.code}\n",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    if (rental.state != 'ACTIVE')
                      ElevatedButton(
                        onPressed: () => activateRental(context),
                        child: const Text('Reservering activeren'),
                      ),
                    const SizedBox(height: 16),
                    if (rental.state == 'ACTIVE') ...[
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Bevestigen'),
                                content: const Text(
                                    'Reservering eindigen en op deze plaats laten ophalen?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Annuleren'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      returnRental(context);
                                    },
                                    child: const Text('Bevestigen'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Reservering eindigen'),
                      ),
                    ],
                    if (rental.state != 'RESERVED') ...[
                      ElevatedButton(
                        onPressed: () =>
                            context.go('/create_inspection/${rental.id}'),
                        child: const Text('Melding maken'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            context.go('/view_inspections/${rental.id}'),
                        child: const Text('Bekijk meldingen'),
                      ),
                    ] else
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Bevestigen'),
                                content: const Text(
                                    'Weet u zeker dat u deze reservering wil annuleren?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
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

    if (isSuccess) {
      RouteHelper.showSnackBarAndNavigate(
          context, 'Reservering is geannuleerd', '/rentals');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Reservering kon niet verwijderd worden. Zijn er actieve meldingen?')),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> activateRental(BuildContext context) async {
    rental.state = 'ACTIVE';
    var isSuccess = await _rentalController.changeRental(rental);

    if (isSuccess) {
      RouteHelper.showSnackBarAndNavigate(
          context, 'Reservering is geactiveerd', '/rentals');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Reservering kon niet geactiveerd worden')),
      );
    }
  }

  Future<void> returnRental(BuildContext context) async {
    try {
      var location = await LocationHelper.determinePosition();
      rental.latitude = location.latitude;
      rental.longitude = location.longitude;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kon locatie niet ophalen')));
      return;
    }

    rental.state = 'PICKUP';

    var isSuccess = await _rentalController.changeRental(rental);

    if (isSuccess) {
      RouteHelper.showSnackBarAndNavigate(
          context, 'Reservering is beëindigt', '/rentals');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Reservering kon niet beëindigt worden')),
      );
    }
  }
}
