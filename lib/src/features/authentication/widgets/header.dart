import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 14.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 25.0, color: Colors.white),
      ),
    );
  }
}