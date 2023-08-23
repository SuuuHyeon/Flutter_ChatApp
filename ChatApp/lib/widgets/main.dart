import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/firebase_options.dart';

import 'package:firebase_practice/helper/helper_function.dart';
import 'package:firebase_practice/pages/auth/login_page.dart';
import 'package:firebase_practice/pages/home_page.dart';
import 'package:firebase_practice/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if(value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Constants().primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? const HomePage() : const LoginPage(),
    );
  }
}
