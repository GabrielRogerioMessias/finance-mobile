import 'package:finance_mobile/src/features/finance/screens/finance_home/widgets/valores_container.dart';
import 'package:flutter/material.dart';

class HeaderFinanceHome extends StatelessWidget {

  final String? userName;
  final double somaReceitas;
  final double somaDespesas;
  final double saldoTotal;


  const HeaderFinanceHome({
    super.key,
    required this.userName,
    required this.somaReceitas,
    required this.somaDespesas,
    required this.saldoTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: 200.0,
          decoration: BoxDecoration(
            color: Color(0xFF227E74),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 14,top: 70),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => print('profile'),
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFF3CB6A9),
                    ),
                  ),
                  SizedBox(
                    width: 270,
                  ),
                  IconButton(
                    onPressed: () => print('settings'),
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFF3CB6A9),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 14.0,bottom: 15),
              child: Row(
                children: [
                  Text(
                    'Olá, ',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    '$userName',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ValoresContainer(
                somaReceitas: somaReceitas,
                somaDespesas: somaDespesas,
                saldoTotal: saldoTotal)
          ],
        ),
      ],
    );
  }
}