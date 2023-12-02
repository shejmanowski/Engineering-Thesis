import 'package:flutter/material.dart';
import 'package:good_mentality/components/dialog_box.dart';
import 'package:good_mentality/components/todo_tile.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key? key, required this.toDoListt, required this.onListUpdated})
      : super(key: key);
  final Future<List> toDoListt;
  final Function(List) onListUpdated;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final _controllerGoal = TextEditingController();
  final _controllerTask = TextEditingController();
  late List newToDoList; // Declare newToDoList variable
  late List toDoList;

  @override
  void initState() {
    super.initState();
    toDoList = [];
    newToDoList = [];
    widget.toDoListt.then((value) {
      setState(() {
        toDoList = value;
        newToDoList = generateNewList(toDoList);
      });
    });
  }

  void modifyTodayTask(int i) {
    setState(() {
      toDoList[i][3] = !toDoList[i][3];
    });
  }

  void saveNewTask() {
    setState(() {
      print(_controllerGoal.text);
      toDoList.add([_controllerGoal.text, _controllerTask.text, false, false]);
      _controllerGoal.clear();
      _controllerTask.clear();
      newToDoList = generateNewList(toDoList);
      widget.onListUpdated(toDoList);
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index, bool goal) {
    setState(() {
      if (goal == true) {
        toDoList.removeWhere((task) => task[0] == newToDoList[index][0]);
      } else if (goal == false) {
        toDoList.removeAt(index);
      }
      newToDoList = generateNewList(toDoList);
    });
    widget.onListUpdated(toDoList);
    print(toDoList);
    print("a");
    print(newToDoList);
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controllerGoal: _controllerGoal,
          controllerTask: _controllerTask,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void checkBoxChanged(bool? value, int index, bool listType) {
    setState(() {
      print(index);
      print(listType);
      print(value);
      if (listType == false) {
        newToDoList[index][1] = value!;
        for (int i = 0; i < toDoList.length; i++) {
          if (toDoList[i][0] == newToDoList[index][0]) {
            toDoList[i][2] = value!;
          }
        }
      } else if (listType == true) {
        toDoList[index][2] = value!;
        newToDoList = generateNewList(toDoList);
      }
    });
    widget.onListUpdated(toDoList);
    print(toDoList);
    print("a");
    print(newToDoList);
  }

  List filterToDoList(List toDoList, List newToDoList) {
    return toDoList
        .where((item) => newToDoList.any((newItem) => newItem[0] == item[0]))
        .toList();
  }

  List generateNewList(List toDoList) {
    Map<String, bool> uniqueValuesMap = {};

    for (var item in toDoList) {
      var key = item[0];
      var value = item[2];

      uniqueValuesMap[key] ??= true;

      if (value == false) {
        uniqueValuesMap[key] = false;
      }
    }

    List result = [];

    uniqueValuesMap.forEach((key, value) {
      result.add([key, value]);
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: widget.toDoListt,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: newToDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: newToDoList[index][0],
                  index: index,
                  taskCompleted: newToDoList[index][1],
                  tasks: toDoList,
                  onChanged: (value, i, list_type) =>
                      checkBoxChanged(value, i, list_type),
                  deleteFunction: (context, goal, i) => deleteTask(index, goal),
                  modifyTodayTask: (i) => modifyTodayTask(i),
                );
              },
            );
          }
        },
      ),
    );
  }
}
