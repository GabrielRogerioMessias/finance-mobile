import 'package:finance_mobile/common/constants/text_constants.dart';
import 'package:flutter/material.dart';

class LogoTextTitle extends StatelessWidget {
  const LogoTextTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return                   Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('lib/assets/logos/finance.png'),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            'Finance',
            style: kLogoText,
          )
        ],
      ),
    );
  }
}
