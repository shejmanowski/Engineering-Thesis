import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_mentality/pages/journal_detail.dart';
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
      final collectionReference = FirebaseFirestore.instance.collection('journal');

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
        title: Text('Twoja historia',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          centerTitle: true,
          elevation: 0,
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
                          'Data: ${entries[index]['timestamp']}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Text(
                          'Humor: ${map(entries[index]['mood'])}',
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
      backgroundColor: Theme.of(context).colorScheme.background,

    );
  }
  String map(String mood){
    String mood_ret;
    switch (mood) {
    case '1':
      mood_ret = "Zły";
      break;
    case '2':
      mood_ret = "Średni";
      break;
    case '3':
      mood_ret = "Dobry";
      break;
    default:
      mood_ret = "?";
  }
    return mood_ret;
  }
}

