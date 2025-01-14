import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_app_development/controllers/RentalController.dart';
import 'package:mobile_app_development/widgets/CarListSortDialog.dart';

import '../DependencyInjection.dart';
import '../helpers/LocationHelper.dart';
import '../models/CarModel.dart';
import 'CarListCard.dart';
import 'CarListFilterDialog.dart';


class CarsList extends StatefulWidget {
  const CarsList({super.key});

  @override
  State<CarsList> createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  final RentalController controller =
      DependencyInjection.getIt.get<RentalController>();
  List<CarModel?> _carList = [];
  List<CarModel?> staticCarList = [];
  double lowestPrice = 0.0;
  double highestPrice = 0.0;
  Map<String, dynamic> _appliedFilters = {
    'brand': [],
    'body': [],
    'fuel': [],
    'lowestPrice': 0.0,
    'highestPrice': 0.0
  };
  var selectedOrder = PriceOrder.asc;

  late LatLng userLocation;
  var userLocationLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchCars();
    setUserLocation();
  }

  refresh() {
    setState(() {});
  }

  updateCarList(List<CarModel?> carList) {
    _carList = carList;
    setState(() {});
  }

  updateFilters(Map<String, dynamic> appliedFilters) {
    _appliedFilters = appliedFilters;
    setState(() {});
  }

  Future<void> setUserLocation() async {
    Position position = await LocationHelper.determinePosition();

    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
      userLocationLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Auto's in de buurt",
                  style: TextStyle(fontSize: 50, color: Color(0xFFFFFFFF)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SearchAnchor(
                    builder: (BuildContext context, SearchController controller) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.7,
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
                  FloatingActionButton(
                    onPressed: () => showDialog(context: context, builder: (BuildContext context) {
                      return CarListFilterDialog(
                        notifyParent: refresh,
                        updateCarList: updateCarList,
                        updateFilters: updateFilters,
                        staticCarList: staticCarList,
                        carList: _carList,
                        appliedFilters: _appliedFilters,
                        lowestPrice: lowestPrice,
                        highestPrice: highestPrice,
                      );
                    }),
                    child: const Icon(Icons.tune),
                  ),
                  FloatingActionButton(
                      onPressed: () => showDialog(context: context, builder: (BuildContext context) {
                        return CarListSortDialog(
                          notifyParent: refresh,
                          selectedOrder: selectedOrder,
                          carList: _carList,
                        );
                      }),
                    child: Icon(Icons.sort),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _carList.isNotEmpty && userLocationLoaded
                    ? ListView.builder(
                        itemCount: _carList.length,
                        itemBuilder: (context, index) {
                          var car = _carList[index];
                          return CarListCard(car: car!, userLocation: userLocation);
                        },
                      )
                    : const Center(child: CircularProgressIndicator())
              ),
            ],
          )),
    );
  }

  void fetchCars() async {
    try {
      final List<CarModel?> carList = await controller.getAllCars();
      setState(() {
        _carList = carList;
        staticCarList = List<CarModel?>.from(carList);
        lowestPrice = _getLowestPrice();
        highestPrice = _getHighestPrice();
        _appliedFilters['lowestPrice'] = _getLowestPrice();
        _appliedFilters['highestPrice'] = _getHighestPrice();
      });
    } catch (e) {
      print(e);
    }
  }

  void _queryCars(String query, carList) async {
    carList.clear();
    for (var i = 0; i < staticCarList.length; i++) {
      if (staticCarList[i]!.brand.toLowerCase().contains(query) ||
          staticCarList[i]!.model.toLowerCase().contains(query)) {
        carList.add(staticCarList[i]);
      }
    }
    setState(() {});
  }

  //Get the lowest price in the unfiltered car list
  double _getLowestPrice() {
    List<double> prices = [];
    for (var i = 0; i < staticCarList.length; i++) {
      prices.add(staticCarList[i]!.price);
    }

    return prices.reduce((current, next) => current < next ? current : next);
  }

  //Get the lowest price in the unfiltered car list
  double _getHighestPrice() {
    List<double> prices = [];
    for (var i = 0; i < staticCarList.length; i++) {
      prices.add(staticCarList[i]!.price);
    }

    return prices.reduce((current, next) => current > next ? current : next);
  }
}
