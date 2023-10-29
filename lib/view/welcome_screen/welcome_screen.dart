import 'package:flutter/material.dart';

import '../login_screen/login_screen.dart';
import '../utils/color.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image.asset('assets/zaphus.png'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width / 1.3,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>const LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  'Start',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500, color: black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
