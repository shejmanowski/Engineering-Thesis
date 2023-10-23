// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:good_mentality/pages/journal_entry_page.dart';

class JournalEntryTile extends StatelessWidget {
  const JournalEntryTile({super.key, required this.entryData});

  final JournalEntryData entryData;

  Color pickColorBasedOnMood(Mood mood) {
    if (mood == Mood.good) {
      return Colors.green.shade700;
    }
    if (mood == Mood.neutral) {
      return Colors.yellow.shade800;
    }
    return Colors.red.shade700;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JournalEntryPage(
                    content: entryData.note,
                  ),
                ));
          },
          child: Ink(
            width: 200,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 50),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Icon(Icons.emoji_emotions,
                        color: pickColorBasedOnMood(entryData.mood)),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entryData.title,
                            style: const TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis),
                        Text(entryData.date, style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
