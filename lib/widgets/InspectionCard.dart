import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/InspectionModel.dart';

class InspectionCard extends StatelessWidget {
  final InspectionModel inspection;

  const InspectionCard({super.key, required this.inspection});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text("Id: ${inspection.id}"),
            subtitle: Text("Beschrijving: ${inspection.description}"),
          ),
          if (inspection.photo != "")
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Image.memory(
                base64Decode(inspection.photo),
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
