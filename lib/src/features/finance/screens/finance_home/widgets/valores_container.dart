import 'package:flutter/material.dart';


class ValoresContainer extends StatelessWidget {
  final double somaReceitas;
  final double somaDespesas;
  final double saldoTotal;

  const ValoresContainer({
    required this.somaReceitas,
    required this.somaDespesas,
    required this.saldoTotal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 250,
      decoration: BoxDecoration(
        color: Color(0xFF4B4B4B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Saldo total',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'R\$ ${saldoTotal.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/icons/Initiate Money Transfer.png'),
                            ),
                            Text(
                              'Receitas',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          'R\$ ${somaReceitas.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Image(
                              image:
                              AssetImage('assets/icons/Request Money.png'),
                            ),
                            Text(
                              'Despesas',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          'R\$ ${somaDespesas.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}