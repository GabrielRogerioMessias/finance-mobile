import 'package:flutter/material.dart';
import 'package:finance_mobile/common/constants/text_constants.dart';

class RememberMe extends StatefulWidget {

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.white,
            ),
            child: Checkbox(
              value: _isChecked,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
          ),
          Text(
              'Remember me',
              style: kTextLabel
          ),
        ],
      ),
    );
  }
}
