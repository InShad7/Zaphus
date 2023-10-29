import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../../utils/constants.dart';

class SignInText extends StatelessWidget {
  const SignInText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 100, left: 17),
          width: 300,
          child: Text(
            'Create an account to get started ',
            style: TextStyle(
              fontSize: 28,
              color: grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        kHeight,

        // kHeight20
      ],
    );
  }
}