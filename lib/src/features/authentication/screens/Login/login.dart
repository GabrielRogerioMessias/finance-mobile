import 'package:finance_mobile/src/features/authentication/models/user_model.dart';
import 'package:finance_mobile/src/features/authentication/screens/Login/buttons/forget_password.dart';
import 'package:finance_mobile/src/features/authentication/screens/Login/buttons/login_button.dart';
import 'package:finance_mobile/src/features/authentication/screens/Login/buttons/remember_me.dart';
import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/authentication/widgets/title_form.dart';
import 'package:finance_mobile/src/features/authentication/screens/Login/widgets/bottom.dart';
import 'package:finance_mobile/src/features/authentication/widgets/header.dart';
import 'package:finance_mobile/src/features/authentication/widgets/input_field.dart';
import 'package:finance_mobile/src/features/finance/finance_home/finance_home.dart';
import 'package:flutter/material.dart';
import 'package:finance_mobile/src/constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await DatabaseHelper.getUserByEmail(email);

    if (user != null && user.password == password) {
      Navigator.pushNamed(context, HomePage.id);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email ou senha incorretos')),
      );
    }
  }

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
                  Header(),
                  SizedBox(
                    height: 30.0,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TitleForm(titleText: 'Login'),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                            controller: emailController,
                            icon: Icons.email,
                            hintText: 'email'),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          controller: passwordController,
                          icon: Icons.lock,
                          hintText: 'senha',
                          obscureText: _obscureText,
                          visible: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),

                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ForgetPassword(),
                        RememberMe(),
                        LoginButton(onLogin: login),
                      ],
                    ),
                  ),
                  BottomLogin(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
