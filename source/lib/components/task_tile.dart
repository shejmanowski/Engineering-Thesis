import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final int index;
  final bool taskCompleted;
  final bool today;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function modifyTodayTask;

  TaskTile({
    super.key,
    required this.taskName,
    required this.index,
    required this.taskCompleted,
    required this.today,
    required this.onChanged,
    required this.deleteFunction,
    required this.modifyTodayTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // checkbox
              Checkbox(
                value: taskCompleted,
                onChanged:
                    onChanged, // Przykładowy indeks (zmień to na właściwy indeks)
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
                  ),
                ),
              ),
              IconButton(
                icon: today
                    ? Icon(Icons.remove)
                    : Icon(Icons.add), // Zmień ikonę na odpowiednią
                onPressed: () {
                  print("gg");
                  modifyTodayTask(); // Dodaj logikę obsługi naciśnięcia ikony przycisku
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomContainer(
      BuildContext context,
      bool taskCompleted,
      String taskName,
      bool today,
      Function(bool?, int, bool) onChanged,
      int i) {
    return Container(
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
              modifyTodayTask; // Dodaj logikę obsługi naciśnięcia ikony przycisku
            },
          ),
        ],
      ),
    );
  }
}
