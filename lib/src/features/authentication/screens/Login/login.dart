import 'package:finance_mobile/src/features/authentication/screens/Login/widgets/bottom.dart';
import 'package:finance_mobile/src/features/authentication/widgets/input.dart';
import 'package:finance_mobile/src/features/authentication/widgets/title.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF373737),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFF373737),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 14.0),
                child: Text(
                  'Faça seu login',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                child: Column(
                  children: [
                    TitleInput(TitleInputText: 'Email'),
                    InputTextField(iconData: Icons.email, hintText: 'email', controller: emailController),
                    SizedBox(
                      height: 20.0,
                    ),
                    TitleInput(TitleInputText: 'Senha'),
                    InputTextField(
                      iconData: Icons.lock,
                      hintText: 'Senha',
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      visible: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF227E74),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 350,
              ),
              Bottom(),
            ],
          )
        ],
      ),
    );
  }
}

