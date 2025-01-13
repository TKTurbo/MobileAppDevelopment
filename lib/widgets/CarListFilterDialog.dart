import 'package:flutter/material.dart';

import 'Accordion.dart';

class CarFilterDialog extends StatefulWidget {
  const CarFilterDialog({super.key});

  @override
  State<CarFilterDialog> createState() => _CarFilterDialogState();
}

class _CarFilterDialogState extends State<CarFilterDialog> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('Filter toevoegen'),
        content: SizedBox(
          width: double.maxFinite,
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
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Vanaf'
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: priceToController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Tot'
                            ),
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
                            return CheckboxListTile(
                              title: Text(_carBrands[index]),
                              value: isChecked,
                              onChanged: (bool? value) {
                                isChecked = !isChecked;
                                _addFilter(isChecked, 'brand', _carBrands[index]);
                              },
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
                            return CheckboxListTile(
                              title: Text(_carBodyTypes[index]),
                              value: isChecked,
                              onChanged: (bool? value) {
                                isChecked = !isChecked;
                                _addFilter(isChecked, 'bodyType', _carBodyTypes[index]);
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
                            return CheckboxListTile(
                              title: Text(_carFuelTypes[index]),
                              value: false,
                              onChanged: (bool? value) {
                                isChecked = !isChecked;
                                _addFilter(isChecked, 'fuelType', _carFuelTypes[index]);
                              },
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
        actions: [
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
              _applyFilters(_appliedFilters);
            },
            child: const Text('Toepassen'),
          ),
        ],

      ),
    );
  }
}