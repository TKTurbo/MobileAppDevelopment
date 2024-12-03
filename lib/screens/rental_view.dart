import 'dart:convert';

import 'package:flutter/material.dart';

class RentalView extends StatefulWidget {
  const RentalView({super.key});

  @override
  State<RentalView> createState() => _RentalViewState();
}

//TODO data via een service laten aanleveren
var tmpData =
    '[{"id": 1, "brand": "Toyota", "model": "Camry", "picture": "", "pictureContentType": "image/jpg", "fuel": "GASOLINE",  "options": "Sunroof", "licensePlate": "ABC123", "engineSize": 3, "modelYear": 2022, "since": "2022-11-02", "price": 100.0, "nrOfSeats": 5, "body": "SEDAN", "longitude": 6.53497, "latitude": 53.238316, "inspections": null, "repairs": null, "rentals": null}, '
        '{"id": 2, "brand": "Mazda", "model": "MX-5", "picture": "", "pictureContentType": "image/jpg", "fuel": "GASOLINE",  "options": "Sunroof", "licensePlate": "ABC123", "engineSize": 3, "modelYear": 2022, "since": "2022-11-02", "price": 100.0, "nrOfSeats": 5, "body": "SEDAN", "longitude": 6.53497, "latitude": 53.238316, "inspections": null, "repairs": null, "rentals": null},' +
        '{"id": 3, "brand": "Opel", "model": "Cadet", "picture": "", "pictureContentType": "image/jpg", "fuel": "GASOLINE",  "options": "Sunroof", "licensePlate": "ABC123", "engineSize": 3, "modelYear": 2022, "since": "2022-11-02", "price": 100.0, "nrOfSeats": 5, "body": "SEDAN", "longitude": 6.53497, "latitude": 53.238316, "inspections": null, "repairs": null, "rentals": null},' +
        '{"id": 4, "brand": "Seat", "model": "Ibiza", "picture": "", "pictureContentType": "image/jpg", "fuel": "GASOLINE",  "options": "Sunroof", "licensePlate": "ABC123", "engineSize": 3, "modelYear": 2022, "since": "2022-11-02", "price": 100.0, "nrOfSeats": 5, "body": "SEDAN", "longitude": 6.53497, "latitude": 53.238316, "inspections": null, "repairs": null, "rentals": null},' +
        '{"id": 5, "brand": "Mitsubishi", "model": "Space Star", "picture": "", "pictureContentType": "image/jpg", "fuel": "GASOLINE",  "options": "Sunroof", "licensePlate": "ABC123", "engineSize": 3, "modelYear": 2022, "since": "2022-11-02", "price": 100.0, "nrOfSeats": 5, "body": "SEDAN", "longitude": 6.53497, "latitude": 53.238316, "inspections": null, "repairs": null, "rentals": null},' +
        '{"id": 6, "brand": "Volkswagen", "model": "Polo", "picture": "", "pictureContentType": "image/jpg", "fuel": "GASOLINE",  "options": "Sunroof", "licensePlate": "ABC123", "engineSize": 3, "modelYear": 2022, "since": "2022-11-02", "price": 100.0, "nrOfSeats": 5, "body": "SEDAN", "longitude": 6.53497, "latitude": 53.238316, "inspections": null, "repairs": null, "rentals": null},' +
        '{"id": 7, "brand": "Honda", "model": "Jazz", "picture": "", "pictureContentType": "image/jpg", "fuel": "GASOLINE",  "options": "Sunroof", "licensePlate": "ABC123", "engineSize": 3, "modelYear": 2022, "since": "2022-11-02", "price": 100.0, "nrOfSeats": 5, "body": "SEDAN", "longitude": 6.53497, "latitude": 53.238316, "inspections": null, "repairs": null, "rentals": null}]';
var jsonData = json.decode(tmpData);
var carList = new List<dynamic>.from(jsonData);

class _RentalViewState extends State<RentalView> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 80),
      child: Column(
        children: [
          const Text(
            "Auto's in de buurt",
            style: TextStyle(fontSize: 50, color: Color(0xFFFFFFFF)),
          ),
          SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return TextField(
                controller: controller,
                onTap: () {
                },
                onChanged: (_) {
                    _queryCars(controller.text);
                },
              );
            }, suggestionsBuilder: (BuildContext context, SearchController controller) {
              //TODO andere manier van renderen resultaten searchbar. Nu wordt er voor niets een builder aangemaakt
              return [];
              },
          ),
          Expanded(
            child: carList.length > 0 ? ListView.builder(
              itemCount: carList.length,
              itemBuilder: (context, index) {
                var car = carList[index];
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () => {
                      //TODO redirect naar auto detailpagina
                    },
                    child: Card(
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "${car['brand']} ${car['model']}",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          //TODO afstand van gps-locatie en auto locatie tonen. Als locatie uit staat, toon dan dorp of stad
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image(
                                    width: double.infinity,
                                    image: NetworkImage(
                                        "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmazdamotoring.com%2Fwp-content%2Fuploads%2F2022%2F08%2F1992_mazda_mx-5_miata-pic-2542735042915584993-1024x768-1.jpeg&f=1&nofb=1&ipt=54bd8557bbb043686b880053e7ba7b2efc536d41da168fa96019c4fbad7ce81a&ipo=images")),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ) : Text("Geen auto's gevonden"),
          ),
        ],
      ),
    );
  }

  void _queryCars(String query) {
    carList.clear();
      for (var i = 0; i < jsonData.length; i++) {
        if (jsonData[i]['brand'].toLowerCase().contains(query) || jsonData[i]['model'].toLowerCase().contains(query)) {
          carList.add(jsonData[i]);
        }
    }
    setState(() {
    });
  }
}
