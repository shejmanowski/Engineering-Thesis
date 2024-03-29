import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_mentality/pages/home.dart';
import 'package:good_mentality/pages/journal.dart';
import 'package:good_mentality/pages/quotes.dart';
import 'package:good_mentality/pages/sleep.dart';
import 'package:good_mentality/pages/task_default.dart';
import 'package:good_mentality/pages/tasks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../auth/auth.dart';
import '../auth/login_or_register.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  const HomePage({super.key, this.selectedIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState(selectedIndex);
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex;

  _HomePageState(this._selectedIndex);
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  }

  final List<Widget> _pages = [
    Home(),
    SleepPage(),
    QuotesPage(),
    TasksDefaultPage(),
    JournalPage(),
  ];

  final List<String> _pagesNames = const [
    "STRONA GŁÓWNA",
    "SENNIK",
    "CYTATY",
    "ZADANIA",
    "DZIENNIK",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          _pagesNames[_selectedIndex],
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: logout,
              icon: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
              ))
        ],
      ),
      body: _pages[_selectedIndex],
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3.0,
            horizontal: 20,
          ),
          child: GNav(
            selectedIndex: _selectedIndex,
            iconSize: 20,
            gap: 5,
            onTabChange: _navigateBottomBar,
            color: Theme.of(context).colorScheme.inversePrimary,
            activeColor: Theme.of(context).colorScheme.secondary,
            backgroundColor: Theme.of(context).colorScheme.primary,
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
