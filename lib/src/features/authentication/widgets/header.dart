import 'package:finance_mobile/src/constants/text_constants.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('lib/assets/logos/finance.png'),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            'Finance',
            style: kTitleTextStyle,
          ),
        ],
      ),
    );
  }
}