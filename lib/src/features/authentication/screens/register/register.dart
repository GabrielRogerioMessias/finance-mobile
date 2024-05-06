import 'package:finance_mobile/src/features/authentication/screens/Login/login.dart';
import 'package:finance_mobile/src/features/authentication/screens/register/widgets/bottom.dart';
import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/authentication/widgets/header.dart';
import 'package:finance_mobile/src/features/authentication/widgets/input_field.dart';
import 'package:finance_mobile/src/features/authentication/widgets/title_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  //Visibilidade da senha
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  //metodo de registro
  void _handleRegister() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmController.text;


    // verificar se todos os campos obrigatórios de registro estão preenchidos
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, preencha todos os campos')));
      return;
    }

    // verificar se as senhas se correspondem
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('As senhas não correspondem.')),
      );
      return;
    }

    // verificar se email ja esta em uso
    final dbHelper = DatabaseHelper.instance;
    bool isEmailInUse = await dbHelper.isEmailAlreadyInUse(email);
    if (isEmailInUse) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Este email ja esta em uso.')),
      );
      return;
    }

    //Chamada do método
    int result = await dbHelper.registerUser(name, email, password);

    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado com sucesso.')),
      );
      Navigator.pushNamed(context, LoginScreen.id);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao registrar o usuário.')),
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
          Container(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(title: 'Crie sua conta'),
                  SizedBox(height: 20.0),
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
                            hintText: 'email',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira um email';
                              }
                              final RegExp emailRegex = RegExp(
                                  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Por favor, insira um email válido';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          TitleInput(text: 'NOME'),
                          InputField(
                              controller: nameController,
                              iconData: Icons.person,
                              hintText: 'nome'),
                          SizedBox(
                            height: 12.0,
                          ),
                          TitleInput(
                            text: 'SENHA',
                          ),
                          InputField(
                            controller: passwordController,
                            iconData: Icons.lock,
                            hintText: 'Senha',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira uma senha';
                              }
                              if (value.length < 7) {
                                return 'A senha deve ter pelo menos 7 caracteres';
                              }
                              if (!value.contains(RegExp(r'[A-Z]'))) {
                                return 'A senha deve conter pelo menos uma letra maiúscula';
                              }
                              if (!value.contains(RegExp(r'[0-9]'))) {
                                return 'A senha deve conter pelo menos um número.';
                              }
                              if (!value.contains(
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                return 'A senha deve conter pelo menos um caractere especial.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          TitleInput(text: 'CONFIRMAR SENHA'),
                          InputField(
                            controller: confirmController,
                            iconData: Icons.lock,
                            hintText: 'Senha',
                            obscureText: _obscureConfirmPassword,
                            visible: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xFF227E74),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, confirme sua senha.';
                              }
                              if (value != passwordController.text) {
                                return 'As senhas não correspondem';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 150.0),
                  BottomRegister(
                    register: _handleRegister,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
