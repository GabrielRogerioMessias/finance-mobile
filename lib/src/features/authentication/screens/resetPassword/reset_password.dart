import 'package:finance_mobile/src/constants/app_colors.dart';
import 'package:finance_mobile/src/features/authentication/models/user_model.dart';
import 'package:finance_mobile/src/features/authentication/screens/resetPassword/buttons/reset_button.dart';
import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/authentication/widgets/header.dart';
import 'package:finance_mobile/src/features/authentication/widgets/input_field.dart';
import 'package:finance_mobile/src/features/authentication/widgets/title_form.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String id = 'reset_screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _nameOrEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<bool> _resetPassword() async {
    String nameOrEmail = _nameOrEmailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('As senhas não coincidem')),
      );
      return false;
    }

    User? user = await DatabaseHelper.getUserByEmail(nameOrEmail);

    if (user == null) {
      user = await DatabaseHelper.getUserByName(nameOrEmail);
    }

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nome ou Email não encontrado')),
      );
      return false;
    }

    bool success = await DatabaseHelper.updateUserPassword(user.email, password);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Senha redefinida com sucesso')),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao redefinir a senha')),
      );
      return false;
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
                    height: 100.0,
                  ),
                  Column(
                    children: [
                      TitleForm(titleText: 'Redefinir senha'),
                      SizedBox(
                        height: 10.0,
                      ),
                      InputField(
                        controller: _nameOrEmailController,
                        icon: Icons.person,
                        hintText: 'Nome ou Email',
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InputField(
                        controller: _passwordController,
                        icon: Icons.lock,
                        hintText: 'senha',
                        obscureText: _obscurePassword,
                        visible:  IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                              !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InputField(
                        controller: _confirmPasswordController,
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
                    ],
                  ),
                  SizedBox(height: 10.0),
                  ResetButton(onReset: _resetPassword),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
