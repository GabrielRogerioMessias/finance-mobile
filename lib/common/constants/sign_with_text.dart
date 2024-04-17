import 'package:flutter/material.dart';
import 'package:finance_mobile/common/constants/text_constants.dart';

class SignInText extends StatelessWidget {
  const SignInText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text('Sign in with', style: kTextLabel),
      ],
    );
  }
}
