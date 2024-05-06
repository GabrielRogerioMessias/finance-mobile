import 'package:finance_mobile/src/features/authentication/screens/resetPassword/reset_password.dart';
import 'package:flutter/material.dart';

class BottomLogin extends StatelessWidget {
  const BottomLogin({
    super.key,
    required this.login,
  });

  final VoidCallback login;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text(
              'Iniciar Sessão',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: login,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(0xFF3CB6A9),
              ),
            ),
          ),
          SizedBox(
            width: 50,
          ),
          GestureDetector(
            child: Text(
              'Esqueci minha senha',
              style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFF3CB6A9),
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF3CB6A9),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, ResetPasswordScreen.id);
            },
          )
        ],
      ),
    );
  }
}
