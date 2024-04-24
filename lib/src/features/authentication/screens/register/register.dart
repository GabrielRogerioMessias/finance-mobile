import 'package:finance_mobile/src/constants/app_colors.dart';
import 'package:finance_mobile/src/features/authentication/models/user_model.dart';
import 'package:finance_mobile/src/features/authentication/screens/register/buttons/register_button.dart';
import 'package:finance_mobile/src/features/authentication/screens/register/widgets/bottom.dart';
import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
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
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  final RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _autoValidate = false;


  void register() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autoValidate = true;
      });
      return;
    }
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('As senhas não são iguais'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    User user = User(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text);

    int result = await DatabaseHelper.addUser(user);
    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registro realizado com sucesso'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erro ao realizar o registro'),
            behavior: SnackBarBehavior.floating),
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
                    key: _formKey,
                    autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        TitleForm(titleText: 'Registrar'),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu nome completo';
                              }
                              return'';
                            },
                            controller: nameController,
                            icon: Icons.person,
                            hintText: 'nome completo',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        InputField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu email';
                              } else if (!emailRegex.hasMatch(value)) {
                                return 'Por favor, insira um email válido';
                              }
                              return'';
                            },
                            controller: emailController,
                            icon: Icons.email,
                            hintText: 'email'),
                        SizedBox(
                          height: 15.0,
                        ),
                        InputField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            }
                            return'';
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            } else if (passwordController.text !=
                                confirmController.text) {
                              return 'As senhas não se condizem';
                            }
                            return'';
                          },
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
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RegisterButton(onRegister: register),
                      ],
                    ),
                  ),
                  BottomRegister(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
