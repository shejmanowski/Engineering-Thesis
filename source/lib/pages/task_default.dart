import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_mentality/pages/daily_tasks.dart';
import 'package:good_mentality/pages/quotes.dart';
import 'package:good_mentality/pages/tasks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TasksDefaultPage extends StatefulWidget {
  @override
  _TasksDefaultPageState createState() => _TasksDefaultPageState();
}

class _TasksDefaultPageState extends State<TasksDefaultPage>
    with WidgetsBindingObserver {
  late GlobalKey<_TasksDefaultPageState> commonKey;
  int _selectedIndex = 0;
  late String userId;
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Tasks');
  late Future<List> toDoList;
  late Future<List> newToDoList; // Declare newToDoList variable

  late List<Widget> _pages;
  final List<String> _pageTitles = ['Cele', 'Dzisiejsze zadania'];
  var lista = [];

  @override
  void initState() {
    super.initState();
    getUserData();
    WidgetsBinding.instance.addObserver(this);
    toDoList = getData();
    newToDoList = generateNewList(toDoList);
    commonKey = GlobalKey<_TasksDefaultPageState>();
    _pages = [
      TasksPage(
        key: commonKey,
        toDoListt: toDoList,
        onListUpdated: updateList,
      ),
      DailyTasksPage(
        key: commonKey,
        toDoListt: toDoList,
        onListUpdated: updateList,
      ),
      TasksDefaultPage(),
    ];
  }

  Future<List> getData() async {
    List newList = [];
    await getRandomQuote().then((value) {
      for (var item in value) {
        newList.add(item);
      }
    });
    return newList;
  }

  Future<List> getRandomQuote() async {
    QuerySnapshot querySnapshot =
        await _collectionReference.where('userId', isEqualTo: userId).get();

    if (querySnapshot.docs.isNotEmpty) {
      // List<Map<String, dynamic>> quotesList = [];
      querySnapshot.docs.forEach((QueryDocumentSnapshot document) {
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;

        String goal = document['goal'].toString();
        String task = document['task'].toString();
        bool today = document['today'] as bool;
        bool active = document['active'] as bool;

        lista.add([goal, task, active, today]);
      });
    }

    return lista;
  }

  void updateList(List newList) {
    setState(() {
      toDoList = Future.value(newList);
      newToDoList = generateNewList(toDoList);
    });
  }

  Future<List> generateNewList(Future<List> toDoList) async {
    List result = [];

    (await toDoList).forEach((item) {
      var key = item[0];
      var value = item[2];

      result.add([key, value]);
    });

    return result;
  }

  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          userId = user.uid;
        });
      }
    } catch (error) {
      print('Błąd: $error');
    }
  }

  void sendDataToFirebase() async {
    List<dynamic> list = await toDoList;
    if (userId != null) {
      await _collectionReference
          .where('userId', isEqualTo: userId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((QueryDocumentSnapshot document) {
          document.reference.delete();
        });
      });
      for (var task in list) {
        await _collectionReference.add({
          "userId": userId,
          "goal": task[
              0], // Zakładam, że "goal" jest pierwszym elementem w liście zadania
          "task": task[
              1], // Zakładam, że "task" jest drugim elementem w liście zadania
          "active": task[2], // Konwertuj bool na String
          "today": task[3], // Konwertuj bool na String
        }).then((DocumentReference document) {
          // Obsługa sukcesu
        }).catchError((error) {
          print("Błąd przy dodawaniu danych: $error");
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Aplikacja jest wstrzymywana, więc wysyłamy dane do Firestore
      sendDataToFirebase();
    }
  }

  @override
  void dispose() {
    // Wysyłanie zmodyfikowanej listy do bazy danych po wyjściu z TasksDefaultPage
    sendDataToFirebase();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .colorScheme
          .background, // Kolor tła podczas oczekiwania
      body: FutureBuilder(
        future: toDoList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return _pages[_selectedIndex];
          }
        },
      ),
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
            onTabChange: _onItemTapped,
            color: Theme.of(context).colorScheme.inversePrimary,
            activeColor: Theme.of(context).colorScheme.secondary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(18),
            tabs: const [
              GButton(
                icon: CupertinoIcons.calendar_badge_plus,
                text: "cele",
              ),
              GButton(
                icon: CupertinoIcons.square_list,
                text: "dzienne zadania",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
