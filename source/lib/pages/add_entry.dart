import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_mentality/pages/homepage.dart';
import 'package:intl/intl.dart';

class AddEntryPage extends StatefulWidget {
  @override
  _AddEntryPageState createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  final TextEditingController textController3 = TextEditingController();
  final TextEditingController textController4 = TextEditingController();

  String selectedOption = "1";
  User? _user;

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('data');

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  void sendDataToFirebase() {
    if (_user != null) {
      var timestamp = DateTime.now();
      var formattedDate = DateFormat('yyyy-MM-dd').format(timestamp);

      _collectionReference.add({
        "userId": _user!.uid,
        "mood": selectedOption,
        "text1": textController1.text,
        "text2": textController2.text,
        "text3": textController3.text,
        "text4": textController4.text,
        "timestamp": formattedDate,
      }).then((DocumentReference document) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(selectedIndex: 4),
          ),
        );
      }).catchError((error) {
        print("Błąd przy dodawaniu danych: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jaki miałeś dzisiaj humor?'),
              RadioListTile(
                title: Text('zły'),
                value: '1',
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value as String;
                  });
                },
              ),
              RadioListTile(
                title: Text('przeciętny'),
                value: '2',
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value as String;
                  });
                },
              ),
              RadioListTile(
                title: Text('dobry'),
                value: '3',
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value as String;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: textController1,
                decoration: InputDecoration(labelText: 'Text 1'),
              ),
              TextField(
                controller: textController2,
                decoration: InputDecoration(labelText: 'Text 2'),
              ),
              TextField(
                controller: textController3,
                decoration: InputDecoration(labelText: 'Text 3'),
              ),
              TextField(
                controller: textController4,
                decoration: InputDecoration(labelText: 'Text 4'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendDataToFirebase,
                child: Text('Send Data to Firestore'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
