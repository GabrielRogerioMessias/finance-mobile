import 'package:finance_mobile/src/features/authentication/screens/register/widgets/header.dart';
import 'package:finance_mobile/src/features/authentication/widgets/input.dart';
import 'package:finance_mobile/src/features/authentication/widgets/title.dart';
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
                children: [
                  Header(),
                  SizedBox(height: 20.0),
                  TitleInput(TitleInputText: 'Email'),
                  InputTextField(
                      iconData: Icons.email,
                      hintText: 'email',
                      controller: emailController),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleInput(TitleInputText: 'Nome'),
                  InputTextField(
                      iconData: Icons.person,
                      hintText: 'nome',
                      controller: nameController),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleInput(TitleInputText: 'Confirmar Senha'),
                  InputTextField(
                    iconData: Icons.lock,
                    hintText: 'Senha',
                    controller: confirmController,
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
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Bottom(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Bottom extends StatelessWidget {
  const Bottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ao prosseguir, aceito os ',
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () => print('Termos de privacidade'),
                child: Text(
                  'termos de privacidade',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xFF3CB6A9),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF3CB6A9),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            child: Text(
              'Criar Conta',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              print('Cadastro realizado!');
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(0xFF3CB6A9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

