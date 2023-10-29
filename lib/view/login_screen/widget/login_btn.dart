import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaphus/view/login_screen/widget/custom_text_field.dart';

import '../../../controller/provider/contoller.dart';
import '../../profile_screen.dart/profile_screen.dart';
import '../../utils/color.dart';
import '../login_screen.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 17,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  Fluttertoast.showToast(
                    msg: 'Enter a valid Phone number',
                    backgroundColor: red,
                  );
                } else {
                  Provider.of<ControllerProvider>(context, listen: false)
                      .saveNumber();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                      (route) => false);
                  Provider.of<ControllerProvider>(context, listen: false)
                      .isLoggedIn();
                }
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24, color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
