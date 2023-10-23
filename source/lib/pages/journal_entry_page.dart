// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

enum Mood { good, neutral, bad }

class JournalEntryData {
  JournalEntryData(this.title, this.gratitude, this.strength, this.proud,
      this.note, this.date, this.mood);

  final String title;
  final String gratitude;
  final String strength;
  final String proud;
  final String note;
  final String date;
  final Mood mood;
}

class JournalEntryPage extends StatelessWidget {
  const JournalEntryPage({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JOURNAL ENTRY',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    'Tytul chyb nie',
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '20.05.2020',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Text(
              '\n' + content,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
