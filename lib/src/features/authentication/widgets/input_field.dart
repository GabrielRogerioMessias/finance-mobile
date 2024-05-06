import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    this.iconData,
    required this.hintText,
    this.visible,
    this.obscureText = false,
    this.validator,
  });

  final TextEditingController controller;
  final IconData? iconData;
  final String hintText;
  final Widget? visible;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          iconData,
          color: Color(0xFF227E74),
        ),
        suffixIcon: visible,
        hintText: hintText,
      ),
      cursorColor: Colors.black,
    );
  }
}
