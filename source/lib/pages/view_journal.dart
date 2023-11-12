import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataPage extends StatefulWidget {
  final String userId;

  FirestoreDataPage({required this.userId});

  @override
  _FirestoreDataPageState createState() => _FirestoreDataPageState();
}

class _FirestoreDataPageState extends State<FirestoreDataPage> {
  late Future<List<Map<String, dynamic>>> data;

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final collectionReference = FirebaseFirestore.instance.collection('data');

      QuerySnapshot querySnapshot = await collectionReference
          .where('userId', isEqualTo: widget.userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> entries = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        entries.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

        return entries;
      }

      return [];
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data'),
      ),
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> entries =
                snapshot.data as List<Map<String, dynamic>>;

            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                Color boxColor;

                switch (entries[index]['mood']) {
                  case "3":
                    boxColor = Colors.green;
                    break;
                  case "2":
                    boxColor = const Color.fromARGB(255, 238, 230, 162);
                    break;
                  case "1":
                    boxColor = Colors.red;
                    break;
                  default:
                    boxColor = Colors.grey;
                    break;
                }

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(entry: entries[index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: boxColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${entries[index]['timestamp']}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Text(
                          'Mood: ${entries[index]['mood']}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> entry;

  DetailPage({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Column(
        children: [
          Text('Date: ${entry['timestamp']}'),
          Text('mood: ${entry['mood']}'),
          Text('text1: ${entry['text1']}'),
          Text('text2: ${entry['text2']}'),
          Text('text3: ${entry['text3']}'),
          Text('text4: ${entry['text4']}'),

        ],
      ),
    );
  }
}