import 'package:flutter/material.dart';
import 'package:good_mentality/components/task_tile.dart';

class DailyTasksPage extends StatefulWidget {
  DailyTasksPage(
      {Key? key, required this.toDoListt, required this.onListUpdated})
      : super(key: key);
  final Future<List> toDoListt;
  final Function(List) onListUpdated;

  @override
  State<DailyTasksPage> createState() => _DailyTasksPage();
}

class _DailyTasksPage extends State<DailyTasksPage> {
  final _controllerGoal = TextEditingController();
  final _controllerTask = TextEditingController();
  late List toDoList;
  late List filteredList;

  @override
  void initState() {
    super.initState();
    widget.toDoListt.then((value) {
      setState(() {
        toDoList = value;
        filteredList = filterToDoList(toDoList);
      });
    });
  }

  List filterToDoList(List toDoList) {
    List trueValuesList =
        toDoList.where((element) => element.last == true).toList();

    return trueValuesList;
  }

  void modifyRecordToDoList(int i, int x, bool delete) {
    for (int j = 0; j < toDoList.length; j++) {
      if (toDoList[j][0] == filteredList[i][0] &&
          toDoList[j][1] == filteredList[i][1]) {
        if (delete == false) {
          toDoList[j][x] = !toDoList[j][x];
          widget.onListUpdated(toDoList);
        } else {
          toDoList.removeAt(j);
        }
        filteredList = filterToDoList(toDoList);
        break;
      }
    }
  }

  void modifyTodayTask(int i) {
    setState(() {
      modifyRecordToDoList(i, 3, false);
      print("dfdffdfdfdfdfa");
    });
  }

  void deleteTask(int index) {
    setState(() {
      modifyRecordToDoList(index, 3, true);
      widget.onListUpdated(toDoList);
    });
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      modifyRecordToDoList(index, 2, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(
        future: widget.toDoListt,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  taskName: filteredList[index][1],
                  index: index,
                  taskCompleted: filteredList[index][2],
                  today: filteredList[index][3],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                  modifyTodayTask: () => modifyTodayTask(index),
                );
              },
            );
          }
        },
      ),
    );
  }
}
