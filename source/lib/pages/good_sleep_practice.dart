import 'package:flutter/material.dart';

class SubPage extends StatelessWidget {
  final int panelNumber;

  SubPage(this.panelNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dobre praktyki:',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text('Zawartość podstrony $panelNumber'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
