import 'package:flutter/material.dart';

class TitleTransacoes extends StatelessWidget {
  const TitleTransacoes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(
        left: 20,
      ),
      child: Text(
        'Histórico de Transações',
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
    );
  }
}