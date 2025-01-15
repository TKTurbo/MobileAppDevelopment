import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/controllers/InspectionController.dart';

import '../DependencyInjection.dart';
import '../models/InspectionModel.dart';
import '../widgets/InspectionCard.dart';

class ViewInspectionsScreen extends StatefulWidget {
  final int rentalId;

  const ViewInspectionsScreen({super.key, required this.rentalId});

  @override
  ViewInspectionsScreenState createState() => ViewInspectionsScreenState();
}

class ViewInspectionsScreenState extends State<ViewInspectionsScreen> {
  final InspectionController _controller =
      DependencyInjection.getIt.get<InspectionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/rentals/${widget.rentalId}'),
            color: const Color(0xFF6F82F8),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Meldingen',
                style: TextStyle(fontSize: 28, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder(
                  future: _controller.getInspections(widget.rentalId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData ||
                        (snapshot.data as List).isEmpty) {
                      return const Center(child: Text('No inspections found.'));
                    }

                    final inspections = snapshot.data as List<InspectionModel>;
                    return ListView.builder(
                      itemCount: inspections.length,
                      itemBuilder: (context, index) {
                        final inspection = inspections[index];
                        return InspectionCard(inspection: inspection);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
