import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_mentality/pages/home.dart';
import 'package:good_mentality/pages/journal.dart';
import 'package:good_mentality/pages/quotes.dart';
import 'package:good_mentality/pages/sleep.dart';
import 'package:good_mentality/pages/tasks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [
    Home(),
    SleepPage(),
    QuotesPage(),
    TasksPage(),
    JournalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: Colors.grey.shade900,
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 20, 20, 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3.0,
            horizontal: 20,
          ),
          child: GNav(
            iconSize: 20,
            gap: 5,
            onTabChange: _navigateBottomBar,
            color: Colors.grey.shade100,
            activeColor: Colors.blue.shade300,
            backgroundColor: const Color.fromARGB(255, 20, 20, 20),
            padding: const EdgeInsets.all(18),
            tabs: const [
              GButton(
                icon: CupertinoIcons.home,
              ),
              GButton(
                icon: CupertinoIcons.moon,
              ),
              GButton(
                icon: CupertinoIcons.quote_bubble,
              ),
              GButton(
                icon: CupertinoIcons.list_bullet,
              ),
              GButton(
                icon: CupertinoIcons.doc_plaintext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
