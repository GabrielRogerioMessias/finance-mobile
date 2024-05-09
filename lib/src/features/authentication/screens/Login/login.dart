import 'package:finance_mobile/src/features/authentication/screens/Login/widgets/bottom.dart';
import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/authentication/widgets/header.dart';
import 'package:finance_mobile/src/features/authentication/widgets/input_field.dart';
import 'package:finance_mobile/src/features/authentication/widgets/title_form.dart';
import 'package:finance_mobile/src/features/finance/screens/finance_home/finance_home.dart';
import 'package:finance_mobile/src/features/provider/user_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //password visible
  bool _obscurePassword = true;

  //Metodo de Login
  void _handleLogin() async {
    String email = emailController.text;
    String password = passwordController.text;

    bool emailExists = await DatabaseHelper.instance.checkIfEmailExist(email);
    if (!emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email não encontrado')),
      );
      return;
    }

    final dbHelper = DatabaseHelper.instance;
    bool isAuthenticated = await dbHelper.authenticateUser(email, password);

    if (isAuthenticated) {
      Map<String, dynamic>? userInfo = await dbHelper.retrieveUserIdAndName(email);
      if (userInfo!= null) {
        Provider.of<UserIdProvider>(context, listen: false).setUserIdAndName(userInfo['user_id'], userInfo['name']);
        Navigator.pushNamed(context, FinanceScreen.id, arguments: email);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao recuperar o ID do usuário')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email ou senha incorretos')),
      );
    }
  }

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
              Header(
                title: 'Faça seu login',
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleInput(text: 'EMAIL'),
                      InputField(
                          controller: emailController,
                          iconData: Icons.email,
                          hintText: 'email'),
                      SizedBox(
                        height: 20.0,
                      ),
                      TitleInput(text: 'SENHA'),
                      InputField(
                        controller: passwordController,
                        iconData: Icons.lock,
                        hintText: 'senha',
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
              ),
              SizedBox(
                height: 350,
              ),
              BottomLogin(login: _handleLogin,),
            ],
          )
        ],
      ),
    );
  }
}
