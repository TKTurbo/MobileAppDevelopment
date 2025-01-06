import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RentalListCard extends StatelessWidget {
  final dynamic rental; // TODO: no dynamic

  const RentalListCard({super.key, required this.rental});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed('rental_details',
          pathParameters: {'rentalId': rental.id.toString()}),
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
                      margin: const EdgeInsets.only(top: 5, left: 5),
                      child: Column(
                        children: [
                          Text(
                            rental.code,
                            style: const TextStyle(fontSize: 25),
                          ),
                          Text(
                            "Van: ${rental.fromDate}",
                            style: const TextStyle(fontSize: 25),
                          ),
                          Text(
                            "Tot: ${rental.toDate}",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
