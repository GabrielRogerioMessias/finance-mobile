import 'package:finance_mobile/src/constants/text_constants.dart';
import 'package:flutter/material.dart';

class bottom extends StatelessWidget {
  const bottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '- OR -',
            style: kTextLabel,
          ),
          Text(
            'SignUp with',
            style: kTextLabel,
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => print('Login with facebook'),
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
              Text('Já possui uma conta?',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Montserrat',
                      color: Colors.white)),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
