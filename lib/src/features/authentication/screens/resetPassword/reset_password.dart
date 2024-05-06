import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/authentication/widgets/header.dart';
import 'package:finance_mobile/src/features/authentication/widgets/input_field.dart';
import 'package:finance_mobile/src/features/authentication/widgets/title_form.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password_screen';

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Método de redefinir senha
  void _resetPassword() {
    String email = _emailController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('As senhas não correspondem.')),
      );
      return;
    }

    DatabaseHelper.instance.resetPassword(email, newPassword);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Senha redefinida com sucesso.')),
    );
    Navigator.pop(context);
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
                title: 'Redefinir Senha',
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleInput(text: 'EMAIL'),
                    InputField(
                        controller: _emailController,
                        iconData: Icons.email,
                        hintText: 'email'),
                    SizedBox(
                      height: 20.0,
                    ),
                    TitleInput(text: 'SENHA'),
                    InputField(
                      controller: _newPasswordController,
                      iconData: Icons.lock,
                      hintText: 'senha',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TitleInput(text: 'CONFIRMAR SENHA'),
                    InputField(
                      controller: _confirmPasswordController,
                      iconData: Icons.lock,
                      hintText: 'confirmar senha',
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFF3CB6A9),
                        ),
                      ),
                      onPressed: _resetPassword,
                      child: Text(
                        'Redefinir senha',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
