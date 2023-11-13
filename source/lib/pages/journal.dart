import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_mentality/pages/add_entry.dart';
import 'package:good_mentality/pages/view_journal.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  late Future<bool> hasEntry;
  late Future<String?> mood;
  late String userId;
  @override
  void initState() {
    super.initState();
    userId = "auzTXJmlmjSIdzwhsibDhio8Ro13";
    mood = getMoodForToday(userId);
  }

  Future<String?> getMoodForToday(String userId) async {
    try {
      final collectionReference = FirebaseFirestore.instance.collection('data');

      String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      QuerySnapshot querySnapshot = await collectionReference
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> entries =
            querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

        var entryForToday = entries.firstWhere(
          (entry) => entry['timestamp'] == todayDate,
          orElse: () => <String, dynamic>{},
        );

        String? moodValue = entryForToday['timestamp'] == todayDate
            ? entryForToday['mood'].toString()
            : null;

        if (moodValue != null) {
          return moodValue;
        } else {
          return null;
        }
      }

      return null;
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        children: <Widget>[
          Text(
            "Twoje dzisiejsze samopoczucie:",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          Align(
            alignment: Alignment(0, 0),
            child: FutureBuilder(
              future: mood,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Błąd: ${snapshot.error}');
                } else {
                  String? mood1 = snapshot.data as String?;

                  IconData iconData;
                  Color iconColor;
                  print(mood1);
                  if (mood1 == '3') {
                    iconData = Icons.sentiment_satisfied_alt_outlined;
                    iconColor = Colors.greenAccent[400] ?? Colors.green;
                  } else if (mood1 == '2') {
                    iconData = Icons.sentiment_neutral_outlined;
                    iconColor = const Color.fromARGB(255, 238, 230, 162);
                  } else if (mood1 == "1") {
                    iconData = Icons.sentiment_very_dissatisfied;
                    iconColor = Colors.red;
                  } else {
                    iconData = CupertinoIcons.question;
                    iconColor = Colors.grey;
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      iconData,
                      size: 300,
                      color: iconColor,
                    ),
                  );
                }
              },
            ),
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FirestoreDataPage(userId: userId),
                            ),
                          );
                        
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.book,
                      size: 50,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              FutureBuilder(
                future: mood,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Błąd: ${snapshot.error}');
                  } else {
                    if (snapshot.data != null) {
                      return Text(' ');
                    } else {
                      return GestureDetector(
                        onTap: () async {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEntryPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.add_circled,
                              size: 50,
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
