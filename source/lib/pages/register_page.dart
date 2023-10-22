import 'package:flutter/material.dart';
import 'package:good_mentality/components/my_button.dart';
import 'package:good_mentality/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  void register() {}

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

              // user textfield
              MyTextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController),

              const SizedBox(height: 10),

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

              // pswrd confirm textfield
              MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: passwordConfirmController),

              const SizedBox(height: 30),

              // sign in button
              MyButton(
                text: "Register",
                onTap: register,
              ),

              const SizedBox(height: 10),

              // dont have account text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      " Login here",
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
