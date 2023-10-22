import 'package:flutter/material.dart';
import 'package:good_mentality/components/my_button.dart';
import 'package:good_mentality/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // logo
              ImageIcon(
                const AssetImage('assets/icons/logo_3.png'),
                size: 150,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              // app name
              const Text('G O O D   M E N T A L I T Y',
                  style: TextStyle(fontSize: 23)),

              const SizedBox(height: 50),

              // email textfield
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController),

              const SizedBox(height: 10),

              // pswrd textfield
              MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController),

              const SizedBox(height: 10),

              // forgot pass?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // sign in button
              MyButton(
                text: "Login",
                onTap: login,
              ),

              const SizedBox(height: 10),

              // dont have account text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      " Register here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
