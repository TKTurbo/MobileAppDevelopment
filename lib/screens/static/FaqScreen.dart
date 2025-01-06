import 'package:flutter/material.dart';

import '../../widgets/MainBottomNavigation.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: const [
            ListTile(
              title: Text('Hoe oud moet ik zijn om een auto te huren?',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              subtitle: Text(
                  'Je moet minimaal 21 jaar oud zijn om een auto te huren bij ons.',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            Divider(),
            ListTile(
              title: Text('Heb ik een rijbewijs nodig?',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              subtitle: Text(
                  'Ja, je hebt een geldig rijbewijs nodig om bij ons een auto te huren.',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            Divider(),
            ListTile(
              title: Text('Kan ik een auto huren zonder creditcard?',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              subtitle: Text(
                  'Een creditcard is vereist voor de borg. Betalingen kunnen ook met andere methoden worden gedaan.',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            Divider(),
            ListTile(
              title: Text('Kan ik de huurauto naar een ander land rijden?',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              subtitle: Text(
                  'Ja, maar dit moet vooraf worden besproken en goedgekeurd. Extra kosten kunnen van toepassing zijn.',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            Divider(),
            ListTile(
              title: Text('Wat gebeurt er als ik de auto te laat terugbreng?',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              subtitle: Text(
                  'Bij te laat terugbrengen wordt er een extra dagtarief in rekening gebracht.',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: const MainBottomNavigation(
        initialIndex: 2,
      ),
    );
  }
}
