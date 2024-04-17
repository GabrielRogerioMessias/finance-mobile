import 'package:finance_mobile/common/constants/logo_text_title.dart';
import 'package:finance_mobile/components/sign_up_button.dart';
import 'package:finance_mobile/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance_mobile/common/constants/forget_password.dart';
import 'package:finance_mobile/common/constants/login_button.dart';
import 'package:finance_mobile/common/constants/remember_me.dart';
import 'package:finance_mobile/common/constants/sign_with_text.dart';
import 'package:finance_mobile/common/constants/text_constants.dart';
import 'package:finance_mobile/common/constants/app_colors.dart';
import 'package:finance_mobile/common/constants/data_input.dart';
import 'package:finance_mobile/components/social_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
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
                    'Sign In',
                    style: kTitleTextStyle,
                  ),
                  SizedBox(height: 30.0),
                  DataInput(
                    label: 'Email',
                    icon: Icons.email,
                    hintText: 'Coloque seu Email',
                  ),
                  SizedBox(height: 30.0),
                  DataInput(
                    label: 'Senha',
                    icon: Icons.lock,
                    hintText: 'Coloque sua senha',
                  ),
                  ForgetPassword(),
                  RememberMe(),
                  LoginButton(),
                  SignInText(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButton(
                        imagePath: 'lib/assets/logos/facebook.jpg',
                        onTap: () => print('Login com Facebook'),
                      ),
                      SocialButton(
                        imagePath: 'lib/assets/logos/google.jpg',
                        onTap: () => print('Login com Google'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  SignUpButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
