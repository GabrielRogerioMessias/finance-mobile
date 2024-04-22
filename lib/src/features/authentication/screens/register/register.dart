import 'package:finance_mobile/src/constants/app_colors.dart';
import 'package:finance_mobile/src/features/authentication/screens/Login/widgets/bottom.dart';
import 'package:finance_mobile/src/features/authentication/screens/register/buttons/register_button.dart';
import 'package:finance_mobile/src/constants/text_constants.dart';
import 'package:finance_mobile/src/features/authentication/widgets/header.dart';
import 'package:finance_mobile/src/features/authentication/widgets/title_form.dart';
import 'package:finance_mobile/src/features/authentication/widgets/input_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
                        TitleForm(titleText: 'Sign Up'),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                            controller: nameController,
                            icon: Icons.person,
                            hintText: 'nome completo'),
                        SizedBox(
                          height: 15.0,
                        ),
                        InputField(
                            controller: emailController,
                            icon: Icons.email,
                            hintText: 'email'),
                        SizedBox(
                          height: 15.0,
                        ),
                        InputField(
                          controller: passwordController,
                          icon: Icons.lock,
                          hintText: 'senha',
                          obscureText: _obscurePassword,
                          visible: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InputField(
                          controller: confirmController,
                          icon: Icons.lock,
                          hintText: 'confirmar senha',
                          obscureText: _obscureConfirmPassword,
                          visible: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RegisterButton(),
                      ],
                    ),
                  ),
                  bottom(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

