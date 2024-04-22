import 'package:finance_mobile/src/constants/text_constants.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: GestureDetector(
        child: Text('Esqueceu sua senha?', style: kTextLabel,),
        onTap: () => print('Esqueceu senha')
      ),
    );
  }
}
