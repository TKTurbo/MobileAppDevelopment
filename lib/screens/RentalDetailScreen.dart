import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/RentalController.dart';
import '../DependencyInjection.dart';
import '../models/CarModel.dart';
import '../models/RentalModel.dart';

class RentalDetailScreen extends StatefulWidget {
  final int rentalId;
  const RentalDetailScreen({super.key, required this.rentalId});

  @override
  State<RentalDetailScreen> createState() => _RentalDetailScreenState();
}

class _RentalDetailScreenState extends State<RentalDetailScreen> {
  final RentalController _rentalController = DependencyInjection.getIt.get<RentalController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _rentalController.getRental(widget.rentalId),
        builder: (BuildContext context, AsyncSnapshot<RentalModel?> snapshot) {
          if (snapshot.hasData) {
            final rental = snapshot.data;
            return Scaffold(
                body: Center(
                  child: Text(rental!.code)
                )
            );
          } else {
            print(snapshot.error);
            return Scaffold(body: Text('Fout bij het laden van de boeking'));
          }
        });
  }
}

