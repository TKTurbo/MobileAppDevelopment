import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/models/RentalModel.dart';

class RentalListCard extends StatelessWidget {
  final RentalModel rental;

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
                      margin: const EdgeInsets.only(top: 10, left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kenmerk: ${rental.code}\n",
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            "Van: ${rental.fromDate} tot ${rental.toDate}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Status: ${rental.state}",
                            style: const TextStyle(fontSize: 20),
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
