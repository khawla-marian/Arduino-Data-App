import 'package:flutter/material.dart';
import 'Registration Files/Sign Up Files/sign_up_page.dart';
import 'splash_screen.dart';
import 'Registration Files/Sign In Files/sign_in_page.dart';
import 'Home Page Files/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arduino Cloud App',
      routes: {
        '/': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/splashscreen': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
