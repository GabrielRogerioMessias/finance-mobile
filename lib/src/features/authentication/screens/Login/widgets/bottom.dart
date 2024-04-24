import 'package:finance_mobile/src/constants/text_constants.dart';
import 'package:finance_mobile/src/features/authentication/screens/register/register.dart';
import 'package:flutter/material.dart';

class BottomLogin extends StatelessWidget {
  const BottomLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '- OU -',
            style: kTextLabel,
          ),
          Text(
            'Login com',
            style: kTextLabel,
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: ()=> print('logar com facebook'),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/assets/logos/facebook.jpg'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.0,
              ),
              GestureDetector(
                onTap: () => print('Login with google'),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/assets/logos/google.jpg'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Não tem uma conta?',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                child: Text(
                  'Registrar',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}



