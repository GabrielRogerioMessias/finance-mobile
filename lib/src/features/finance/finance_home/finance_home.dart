import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

 static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login feito com sucesso'),
        ],
      ),

    );
  }
}
