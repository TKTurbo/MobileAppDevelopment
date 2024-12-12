import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_development/controllers/RentalController.dart';

import '../DependencyInjection.dart';
import '../models/CarModel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final RentalController controller = DependencyInjection.getIt.get<RentalController>();
  var _carList = [];
  var staticCarList = [];

  @override
  void initState() {
    super.initState();
    _fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 80),
          child: Column(
            children: [
              const Text(
                "Auto's in de buurt",
                style: TextStyle(fontSize: 50, color: Color(0xFFFFFFFF)),
              ),
              SearchAnchor(
                builder:
                    (BuildContext context, SearchController controller) {
                  return TextField(
                    controller: controller,
                    onTap: () {},
                    onChanged: (_) {
                      _queryCars(controller.text, _carList);
                    },
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  //TODO andere manier van renderen resultaten searchbar. Nu wordt er voor niets een builder aangemaakt
                  return [];
                },
              ),
              Expanded(
                child: _carList.length > 0
                    ? ListView.builder(
                        itemCount: _carList.length,
                        itemBuilder: (context, index) {
                          var car = _carList[index];
                          var imageBlob = car.picture;
                          var image = Base64Codec().decode(imageBlob);
                          return Container(
                            margin: EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: () => context.goNamed('car_details', pathParameters: {'carId': car.id.toString()}),
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
                                                alignment:
                                                    Alignment.centerLeft,
                                                margin:
                                                    const EdgeInsets.only(
                                                  top: 5,
                                                  left: 5,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${car.brand} ${car.model}",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                    //TODO afstand van gps-locatie en auto locatie tonen. Als locatie uit staat, toon dan dorp of stad
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Image.memory(image),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Text("Geen auto's gevonden"),
              ),
            ],
          )),
    );
  }

  void _fetchCars() async {
    try {
      final carList = await controller.getAllCars();
      setState(() {
        _carList = carList;
        staticCarList = new List<CarModel>.from(carList);
      });
    } catch (e) {
      print(e);
    }
  }

  void _queryCars(String query, carList) async {

    carList.clear();
    for (var i = 0; i < staticCarList.length; i++) {
      if (staticCarList[i].brand.toLowerCase().contains(query) ||
          staticCarList[i].model.toLowerCase().contains(query)) {
        carList.add(staticCarList[i]);
      }
    }
    setState(() {});
  }
}
