import 'dart:convert';

import 'package:flutter/material.dart';

class CarListView extends StatefulWidget {
  const CarListView({
    super.key
  });

  @override
  State<CarListView> createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> {
  @override
  Widget build(BuildContext context) {
    //TODO data via de api ophalen

    var tmpData = '[{"id": 1, "brand": "Toyota", "model": "Camry", "picture": "", "pictureContentType": "image/jpg", "fuel": "GASOLINE",  "options": "Sunroof", "licensePlate": "ABC123", "engineSize": 3, "modelYear": 2022, "since": "2022-11-02", "price": 100.0, "nrOfSeats": 5, "body": "SEDAN", "longitude": 6.53497, "latitude": 53.238316, "inspections": null, "repairs": null, "rentals": null}, {"id": 2, "brand": "Mazda", "model": "Camry", "picture": "", "pictureContentType": "image/jpg", "fuel": "GASOLINE",  "options": "Sunroof", "licensePlate": "ABC123", "engineSize": 3, "modelYear": 2022, "since": "2022-11-02", "price": 100.0, "nrOfSeats": 5, "body": "SEDAN", "longitude": 6.53497, "latitude": 53.238316, "inspections": null, "repairs": null, "rentals": null}]';
    var jsonData = json.decode(tmpData);

    return ListView.builder(
        itemCount: jsonData.length,
        itemBuilder: (context, index) {
          var car = jsonData[index];
          return GestureDetector(
            onTap: () => {
              //TODO redirect naar auto detailpagina
            },
            child: Card(
                child: Column(
                  children: [
                    //TODO afstand tussen gps-locatie en coördinaten auto berekenen
                    Text(car['brand'] + ' ' + car['model'])
                  ],
                ),
              ),
          );
        },
    );
  }
}

