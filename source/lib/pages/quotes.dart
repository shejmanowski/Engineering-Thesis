import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_mentality/components/my_button.dart';
import 'package:good_mentality/components/my_textfield.dart';
import 'dart:math';

class QuotesPage extends StatefulWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  final TextEditingController quoteController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  late Future<List<String>> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = getRandomQuote();
  }

  Future<void> createQuoteDocument() async {
    String quote = quoteController.text;
    String quoteAuthor = authorController.text;

    if (quote.isNotEmpty && quoteAuthor.isNotEmpty) {
      await FirebaseFirestore.instance.collection("Quotes").doc(quote).set({
        'quote': quote,
        'quoteAuthor': quoteAuthor,
        'quuoteAccepted': "0",
      });
    }
  }

  Future<List<String>> getRandomQuote() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Quotes')
        .where('quuoteAccepted', isEqualTo: '1')
        .get();

    var random = Random();
    var randomDocument =
        querySnapshot.docs.elementAt(random.nextInt(querySnapshot.docs.length));

    return [randomDocument['quote'], randomDocument['quoteAuthor']];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => addQuoteDialogBox(),
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
              const SizedBox(height: 50),
              FutureBuilder<List<String>>(
                future: futureQuote,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            snapshot.data![0],
                            style: const TextStyle(
                              fontSize: 35,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Author: ${snapshot.data![1]}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic, // Dodaj kursywę
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 50),
              MyButton(
                text: "I need a new quote",
                onTap: () {
                  setState(() {
                    futureQuote = getRandomQuote();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
