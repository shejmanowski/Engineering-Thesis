// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:good_mentality/components/my_button.dart';
import 'package:good_mentality/components/my_textfield.dart';
import "dart:math";

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  final TextEditingController quoteController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  var currentQuote = "...";

  void addQuoteDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          content: SizedBox(
            height: 230,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyTextField(
                    hintText: "Type quote...",
                    obscureText: false,
                    controller: quoteController,
                  ),
                  MyTextField(
                    hintText: "Type author...",
                    obscureText: false,
                    controller: authorController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButton(
                        text: "Cancel",
                        onTap: () {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            quoteController.clear();
                            authorController.clear();
                          }
                        },
                      ),
                      MyButton(
                        text: "  Add  ",
                        onTap: () {
                          createQuoteDocument();
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            quoteController.clear();
                            authorController.clear();
                          }
                        },
                      ),
                    ],
                  )
                ]),
          ),
        );
      },
    );
  }

  Future<void> createQuoteDocument() async {
    String quote = quoteController.text;
    String quoteAuthor = authorController.text;

    if (quote != "" && quoteAuthor != "") {
      await FirebaseFirestore.instance.collection("Quotes").doc(quote).set({
        'quote': quote,
        'quoteAuthor': quoteAuthor,
        'quuoteAccepted': "0"
      });
    }
  }

  Future<void> getRandomQuote() async {
    setState(() {
      FirebaseFirestore.instance
          .collection('Quotes')
          .where('quuoteAccepted', isEqualTo: '1')
          .get()
          .then((QuerySnapshot querySnapshot) {
        var random = Random();
        currentQuote = querySnapshot.docs
            .elementAt(random.nextInt(querySnapshot.docs.length))['quote'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: addQuoteDialogBox,
          tooltip: 'Add new quote',
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: Image.asset(
                    'assets/images/brain.png',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    currentQuote,
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                MyButton(
                  text: "I need new quote",
                  onTap: getRandomQuote,
                ),
              ],
            ),
          ),
        ));
  }
}
