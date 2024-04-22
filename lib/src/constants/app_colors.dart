import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF227E74);
  static const Color secondary = Color(0xFF3CB6A9);
  static const Color thirdly = Color(0xFF344F5D);
  static const Color white = Color(0xFFFFFFFF);

  static const List<Color> kGreenGradient = [
    Color(0xFF227E74),
    Color(0xFF3CB6A9),
  ];
}

const kBoxDecorationGradient = BoxDecoration(
  gradient: LinearGradient(
      colors: [Color(0xFF227E74), Color(0xFF3CB6A9)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter),
);


const kBoxDecorationInputText = BoxDecoration(
  color: Color(0xFF298C82),
  borderRadius: BorderRadius.all(
    Radius.circular(15),
  ),
  boxShadow: [
    BoxShadow(
      color: Color(0xFF217068),
      blurRadius: 3.0,
      spreadRadius: 0.9,
      offset: Offset(0, 3),
    ),
  ],
);
