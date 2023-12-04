// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_mentality/components/dialog_button.dart';
import 'package:email_validator/email_validator.dart';

class DialogForgot extends StatefulWidget {
  DialogForgot({
    super.key,
  });

  @override
  State<DialogForgot> createState() => _DialogForgotState();
}

class _DialogForgotState extends State<DialogForgot> {
  final controllerEmail = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            Text(
              "Receive an email to reset your password.",
              textAlign: TextAlign.center,
            ),
            TextFormField(
              controller: controllerEmail,
              cursorColor: Theme.of(context).colorScheme.inversePrimary,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter email",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? "Enter a valid email"
                      : null,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                sendMail(context);
              },
              icon: Icon(
                Icons.email_outlined,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              label: Text("Reset Password",
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future sendMail(context) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: controllerEmail.text.trim())
        .then((void v) {
      final snackBar = SnackBar(
        content: const Text('Sent!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    }).catchError((e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
