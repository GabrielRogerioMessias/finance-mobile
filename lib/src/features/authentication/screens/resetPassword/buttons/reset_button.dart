import 'package:flutter/material.dart';

class ResetButton extends StatefulWidget {
  const ResetButton({super.key, required this.onReset});

  final Function() onReset;

  @override
  State<ResetButton> createState() => _ResetButtonState();
}

class _ResetButtonState extends State<ResetButton> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          bool success = await
          widget.onReset();
          if (success) {
          Navigator.pop(context);
          } else {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao redefinir a senha')),
          );
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          'REDEFINIR SENHA',
          style: TextStyle(color: Color(0xFF227E74), letterSpacing: 1.5),
        ),
      ),
    );
  }
}
