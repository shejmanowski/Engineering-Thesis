import 'dart:math';

import 'package:flutter/material.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {

  final List<String> _quotes = const [
    "Be the change that you wish to see in the world.",
    "A day without laughter is a day wasted.",
    "You talk when you cease to be at peace with your thoughts.",
    "May you live every day of your life.",
    "There is nothing either good or bad, but thinking makes it so.",
  ];

  String _pickQuote(){
    var index = Random().nextInt(5);
    return _quotes[index];
  }

  void _addQuote(String quote){
    _quotes.add(quote);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        children: [
          const Center(
            child: Text(
              'Quotes',
              style: TextStyle(fontSize: 50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: Text(
                _pickQuote(),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}