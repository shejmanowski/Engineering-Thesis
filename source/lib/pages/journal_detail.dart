import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> entry;

  DetailPage({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Szczegóły',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          centerTitle: true,
          elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildFieldContainer('Data', entry['timestamp'],context),
            _buildFieldContainer('Humor', entry['mood'],context),
            _buildFieldContainer('Co pozytywnie wpłynęło na twój humor?', entry['text1'],context),
            _buildFieldContainer('Jakie przeciwnosci cię spotkały?', entry['text2'],context),
            _buildFieldContainer('Za co jesteś wdzięczny?', entry['text3'],context),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,

    );
  }

  Widget _buildFieldContainer(String label, dynamic value, context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Szerokość równa szerokości ekranu
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:  Theme.of(context).colorScheme.primary, // Kolor tła prostokąta
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary// Kolor tekstu
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 16.0,
              color:  Theme.of(context).colorScheme.inversePrimary
            ),
          ),
        ],
      ),
    );
  }
}