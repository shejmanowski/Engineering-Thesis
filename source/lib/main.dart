import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_mentality/auth/auth.dart';
import 'package:good_mentality/firebase_options.dart';
import 'package:good_mentality/theme/dark_mode.dart';
import 'package:good_mentality/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
