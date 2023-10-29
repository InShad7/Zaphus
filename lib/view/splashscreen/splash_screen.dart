import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaphus/view/utils/color.dart';
import 'package:zaphus/view/welcome_screen/welcome_screen.dart';

import '../home_screen/home_screen.dart';
import '../login_screen/login_screen.dart';

bool isloggedIn = false;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Center(
        child: Image.asset('assets/zaphus.png'),
      ),
    );
  }

  void checkLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    bool loggedIn = sharedPrefs.getBool('isLoggedIn') ?? false;
    setState(() {
      isloggedIn = loggedIn;
    });
    if (isloggedIn == true) {
      await Future.delayed(
        const Duration(seconds: 1),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      await Future.delayed(
        const Duration(seconds: 1),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomScreen(),
        ),
      );
    }
  }
}
