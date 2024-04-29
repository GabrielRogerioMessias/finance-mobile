import 'package:finance_mobile/src/constants/app_colors.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'finance',
        ),
        backgroundColor: Color(0xFF2A8D81),
        shadowColor: Colors.black26,
        elevation: 4,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: kBoxDecorationGradient,
          )
        ],
      ),
    );
  }
}
