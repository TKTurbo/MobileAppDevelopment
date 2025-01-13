import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/CarModel.dart';
import 'Accordion.dart';

class CarListFilterDialog extends StatefulWidget {
  final Function() notifyParent;
  final Function(List<CarModel?>) updateCarList;
  final Function(Map<String, dynamic>) updateFilters;
  final List<CarModel?> staticCarList;
  Map<String, dynamic> appliedFilters;
  List<CarModel?> carList;
  double lowestPrice;
  double highestPrice;

  CarListFilterDialog({
    super.key,
    required this.notifyParent,
    required this.updateCarList,
    required this.updateFilters,
    required this.staticCarList,
    required this.carList,
    required this.appliedFilters,
    required this.lowestPrice,
    required this.highestPrice
  });

  @override
  State<CarListFilterDialog> createState() => _CarListFilterDialogState();
}

class _CarListFilterDialogState extends State<CarListFilterDialog> {
  var _carBrands = [];
  var _carBodyTypes = [];
  var _carFuelTypes = [];
  var highestPrice = 0.0;
  var lowestPrice = 0.0;

  final priceFromController =
    TextEditingController();
  final priceToController =
    TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupFilters(widget.staticCarList);
  }

  @override
  Widget build(BuildContext context) {
    priceFromController.text = lowestPrice.toString();
    priceToController.text = highestPrice.toString();

    return Scaffold(
      body: AlertDialog(
        title: const Text('Filter toevoegen'),
        content: SizedBox(
          width: double.maxFinite,
          height: 600,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Accordion(
                  title: Text('Prijs'),
                  content: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: priceFromController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Vanaf'
                              ),
                              onChanged: (value) {
                                lowestPrice = double.parse(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: priceToController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Tot'
                              ),
                              onChanged: (value) {
                                highestPrice = double.parse(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Accordion(
                  title: Text('Merk'),
                  content: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 200,
                        child:  ListView.builder(
                            itemCount: _carBrands.length,
                            itemBuilder: (context, int index) {
                              var isChecked = false;
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  //Check the checkkbox if the filter has been set in a previous state
                                  if (widget.appliedFilters['brand']!.contains(_carBrands[index])) {
                                    isChecked = true;
                                  }
                                  return CheckboxListTile(
                                    title: Text(_carBrands[index]),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                        if (isChecked) {
                                          _addFilter('brand', _carBrands[index]);
                                        } else {
                                          _removeFilter('brand', _carBrands[index]);
                                        }
                                      });
                                    },
                                  );
                                }

                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
                Accordion(
                  title: const Text('Carrosserievorm'),
                  content: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 200,
                        child:  ListView.builder(
                            itemCount: _carBodyTypes.length,
                            itemBuilder: (context, int index) {
                              var isChecked = false;
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  //Check the checkkbox if the filter has been set earlier
                                  if (widget.appliedFilters['body']!.contains(_carBodyTypes[index])) {
                                    isChecked = true;
                                  }
                                  return CheckboxListTile(
                                    title: Text(_carBodyTypes[index]),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                        if (isChecked) {
                                          _addFilter('body', _carBodyTypes[index]);
                                        } else {
                                          _removeFilter('body', _carBodyTypes[index]);
                                        }
                                      });
                                      },
                                  );
                                },

                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
                Accordion(
                  title: const Text('Brandstoftype'),
                  content: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 200,
                        child:  ListView.builder(
                            itemCount: _carFuelTypes.length,
                            itemBuilder: (context, int index) {
                              var isChecked = false;
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  //Check the checkkbox if the filter has been set earlier
                                  if (widget.appliedFilters['fuel']!.contains(_carFuelTypes[index])) {
                                    isChecked = true;
                                  }
                                  return CheckboxListTile(
                                    title: Text(_carFuelTypes[index]),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                        if (isChecked) {
                                          _addFilter('fuel', _carFuelTypes[index]);
                                        } else {
                                          _removeFilter('fuel', _carFuelTypes[index]);
                                        }
                                      });
                                    },
                                  );
                                }
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Annuleren'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _clearFilters();
            },
            child: const Text('Filters verwijderen'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              lowestPrice = double.parse(priceFromController.text);
              highestPrice = double.parse(priceToController.text);
              _applyFilters();
            },
            child: const Text('Toepassen'),
          ),
        ],

      ),
    );
  }

  void _setupFilters(carList) {
    final brands = [];
    final bodyTypes = [];
    final fuelTypes = [];
    final prices = [];

    for (var i = 0; i < carList.length; i++) {
      brands.add(carList[i].brand);
      bodyTypes.add(carList[i].body);
      fuelTypes.add(carList[i].fuel);
      prices.add(carList[i].price);
    }

    _carBrands = brands.toSet().toList();
    _carBodyTypes = bodyTypes.toSet().toList();
    _carFuelTypes = fuelTypes.toSet().toList();
    lowestPrice = widget.appliedFilters['lowestPrice'];
    highestPrice = widget.appliedFilters['highestPrice'];
  }

  _addFilter(String filter, String value) {
    if (!widget.appliedFilters[filter]!.contains(value)) {
      widget.appliedFilters[filter]?.add(value);
    }
    widget.updateFilters(widget.appliedFilters);
  }

  _removeFilter(String filter, String value) {
    if (widget.appliedFilters[filter]!.contains(value)) {
      widget.appliedFilters[filter]?.remove(value);
    }
    widget.updateFilters(widget.appliedFilters);
  }

  _applyFilter(String filter, List<CarModel?> filteredList) {
    if (!widget.appliedFilters[filter]!.isEmpty) {
      for (var i = 0; i < widget.carList.length; i++) {
        var car = json.decode(widget.carList[i]!.toJson());
        if (widget.appliedFilters[filter]!.contains(car[filter])) {
          filteredList.add(widget.carList[i]);
        }
      }
      widget.carList = List<CarModel?>.from(filteredList);
      filteredList.clear();
    }
  }

  _applyFilters() {
    List<CarModel?> filteredList = _getCarsInPriceRange();

    widget.carList = List<CarModel?>.from(filteredList);
    widget.appliedFilters['lowestPrice'] = lowestPrice;
    widget.appliedFilters['highestPrice'] = highestPrice;
    widget.updateFilters(widget.appliedFilters);

    filteredList.clear();
    _applyFilter('brand', filteredList);
    _applyFilter('body', filteredList);
    _applyFilter('fuel', filteredList);

    widget.updateCarList(widget.carList);
  }

  _clearFilters() {
    widget.carList = List<CarModel>.from(widget.staticCarList);
    widget.appliedFilters['brand'] = [];
    widget.appliedFilters['body'] = [];
    widget.appliedFilters['fuel'] = [];
    widget.appliedFilters['lowestPrice'] = widget.lowestPrice;
    widget.appliedFilters['highestPrice'] = widget.highestPrice;
    widget.updateCarList(widget.carList);
    widget.updateFilters(widget.appliedFilters);
  }

  List<CarModel?> _getCarsInPriceRange() {
    List<CarModel?> carList = [];
    for (var i = 0; i < widget.staticCarList.length; i++) {
      if (widget.staticCarList[i]!.price >= lowestPrice
          && widget.staticCarList[i]!.price <= highestPrice) {
        carList.add(widget.staticCarList[i]);
      }
    }

    return carList;
  }
}