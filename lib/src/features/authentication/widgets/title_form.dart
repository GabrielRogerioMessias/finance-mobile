import 'package:flutter/material.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
      TextStyle(color: Colors.white, fontSize: 18.0),
    );
  }
}