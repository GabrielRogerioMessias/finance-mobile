import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final Widget? visible;
  final bool obscureText;

  const InputField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.visible,
    this.obscureText = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey),
        ),

        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        suffixIcon: visible,
        labelText:hintText,
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}

