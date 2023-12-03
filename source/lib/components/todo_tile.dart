import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final int index;
  final bool taskCompleted;
  final List tasks;
  Function(bool?, int, bool) onChanged;
  Function(BuildContext, bool, int) deleteFunction;
  Function(int) modifyTodayTask;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.index,
    required this.taskCompleted,
    required this.tasks,
    required this.onChanged,
    required this.deleteFunction,
    required this.modifyTodayTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: ExpansionTile(
        textColor: Theme.of(context).colorScheme.inversePrimary,
        title: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (value) => deleteFunction(value, true, index),
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(12),
              )
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // checkbox
                Checkbox(
                  value: taskCompleted,
                  onChanged: (value) => onChanged(value, index,
                      false), // Przykładowy indeks (zmień to na właściwy indeks)
                  activeColor: Colors.black,
                ),

                // task name
                Expanded(
                  child: Text(
                    taskName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        children: buildChildren(context),
      ),
    );
  }

  List<Widget> buildChildren(context) {
    List<Widget> children = [];

    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i][0] == taskName) {
        children.add(
          buildCustomContainer(
            context,
            tasks[i][2],
            tasks[i][1],
            tasks[i][3],
            onChanged,
            i,
          ),
        );
      }
    }

    return children;
  }

  Widget buildCustomContainer(
      BuildContext context,
      bool taskCompleted,
      String taskName,
      bool today,
      Function(bool?, int, bool) onChanged,
      int i) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (value) => deleteFunction(value, false, index),
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(12),
          )
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // checkbox
            Checkbox(
              value: taskCompleted,
              onChanged: (value) => onChanged(value, i,
                  true), // Przykładowy indeks (zmień to na właściwy indeks)
              activeColor: Colors.black,
            ),

            // task name
            Expanded(
              child: Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: today
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            IconButton(
              icon: today
                  ? Icon(Icons.remove)
                  : Icon(Icons.add), // Zmień ikonę na odpowiednią
              onPressed: () {
                modifyTodayTask(
                    i); // Dodaj logikę obsługi naciśnięcia ikony przycisku
              },
            ),
          ],
        ),
      ),
    );
  }
}
