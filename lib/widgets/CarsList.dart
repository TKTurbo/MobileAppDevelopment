import 'package:flutter/material.dart';
import 'package:mobile_app_development/controllers/RentalController.dart';

import '../DependencyInjection.dart';
import '../models/CarModel.dart';
import 'CarListCard.dart';

class CarsList extends StatefulWidget {
  const CarsList({super.key});

  @override
  State<CarsList> createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  final RentalController controller =
      DependencyInjection.getIt.get<RentalController>();
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
          margin: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              const Center(
                child: const Text(
                  "Auto's in de buurt",
                  style: TextStyle(fontSize: 50, color: Color(0xFFFFFFFF)),
                ),
              ),
              const SizedBox(height: 16),
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: controller,
                      onTap: () {},
                      onChanged: (_) {
                        _queryCars(controller.text, _carList);
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: "Zoeken op auto's",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  //TODO andere manier van renderen resultaten searchbar. Nu wordt er voor niets een builder aangemaakt
                  return [];
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _carList.isNotEmpty
                    ? ListView.builder(
                        itemCount: _carList.length,
                        itemBuilder: (context, index) {
                          var car = _carList[index];
                          return CarListCard(car: car);
                        },
                      )
                    : const Text("Geen auto's gevonden"),
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
        staticCarList = List<CarModel>.from(carList);
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
