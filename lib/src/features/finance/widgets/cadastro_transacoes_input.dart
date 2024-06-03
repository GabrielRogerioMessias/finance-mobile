import 'package:flutter/material.dart';

class CadastroTransacaoInput extends StatelessWidget {
  const CadastroTransacaoInput(
      {Key? key,
        required this.controller,
        required this.hint,
        required this.inputType,
        required this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.black),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint),
    );
  }
}