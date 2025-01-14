import 'package:flutter/material.dart';

import '../models/CarModel.dart';

class CarListSortDialog extends StatefulWidget {
  final Function() notifyParent;
  var selectedOrder;
  final List<CarModel?> carList;

  CarListSortDialog({
    super.key,
    required this.notifyParent,
    required this.selectedOrder,
    required this.carList,
  });

  @override
  State<CarListSortDialog> createState() => _CarListSortDialogState();
}

enum PriceOrder { asc, desc }

class _CarListSortDialogState extends State<CarListSortDialog> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
          title: Text('Sorteren'),
          content: SizedBox(
            height: 125,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    children: [
                      ListTile(
                        title: const Text('Prijs oplopend'),
                        leading: Radio(
                          value: PriceOrder.asc,
                          groupValue: widget.selectedOrder,
                          onChanged: (value) {
                            setState(() => widget.selectedOrder = value!);
                            widget.notifyParent();
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Prijs aflopend'),
                        leading: Radio(
                          value: PriceOrder.desc,
                          groupValue: widget.selectedOrder,
                          onChanged: (value) {
                            setState(() => widget.selectedOrder = value!);
                            widget.notifyParent();
                          },
                        ),
                      ),
                    ],
                  );
                }

            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _sortCarList();
              },
              child: Text('Toepassen'),
            )
          ]
      )
    );
  }

  _sortCarList() {
    if (widget.selectedOrder == PriceOrder.asc) {
      widget.carList.sort((a, b) => a!.price.compareTo(b!.price));
    }
    if (widget.selectedOrder == PriceOrder.desc) {
      widget.carList.sort((a, b) => b!.price.compareTo(a!.price));
    }

    widget.notifyParent();
  }
}