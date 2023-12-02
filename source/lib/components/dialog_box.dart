// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:good_mentality/components/dialog_button.dart';

class DialogBox extends StatelessWidget {
  final controllerGoal;
  final controllerTask;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controllerGoal,
    required this.controllerTask,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Container(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controllerGoal,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add goal",
              ),
            ),
            TextField(
              controller: controllerTask,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                DialogButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 8),

                // cancel button
                DialogButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
