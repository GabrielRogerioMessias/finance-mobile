import 'package:finance_mobile/common/constants/app_colors.dart';
import 'package:finance_mobile/common/constants/data_input.dart';
import 'package:finance_mobile/common/constants/logo_text_title.dart';
import 'package:finance_mobile/common/constants/register_button.dart';
import 'package:finance_mobile/common/constants/text_constants.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: kBoxDecorationGradient,
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 90.0),
              child: Column(
                children: [
                  LogoTextTitle(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Sign Up',
                    style: kTitleTextStyle,
                  ),
                  SizedBox(height: 20.0,),
                  DataInput(label: 'Nome completo', icon: Icons.person, hintText: 'Nome completo'),
                  SizedBox(height: 10.0,),
                  DataInput(label: 'Email', icon: Icons.email, hintText: 'Email'),
                  SizedBox(height: 10.0,),
                  DataInput(label: 'Senha', icon: Icons.lock, hintText: 'Senha'),
                  SizedBox(height: 10.0,),
                  DataInput(label: 'Confirmar senha', icon: Icons.lock, hintText: 'Senha'),
                  SizedBox(height: 30.0,),
                  RegisterButton(),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
