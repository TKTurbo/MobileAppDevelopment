import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final Widget title;
  final Widget content;

  const Accordion({required this.title, required this.content});

  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: widget.title,
            trailing: IconButton(
              icon: Icon(
                  _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              onPressed: () {
                _showContent = !_showContent;
                setState(() {});
              },
            ),
          ),
          _showContent
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: widget.content,
                )
              : Container()
        ],
      ),
    );
  }
}
