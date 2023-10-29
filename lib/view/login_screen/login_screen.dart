import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaphus/controller/provider/contoller.dart';

import '../utils/color.dart';
import '../utils/constants.dart';
import 'widget/custom_text_field.dart';
import 'widget/login_btn.dart';
import 'widget/sign_in_text.dart';

final formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: blue,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SignInText(),
                kHeight20,
                MyTextField(
                  isNumber: true,
                  title: '+91| Mobile Number',
                  myControler:Provider.of<ControllerProvider>(context).phoneController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Number can\'t be empty';
                    } else if (val.length != 10) {
                      return 'Please enter a 10-digit number';
                    }
                  },
                ),
                kHeight30,
                const LoginBtn(),
              ]),
        ),
      ),
    );
  }
}
