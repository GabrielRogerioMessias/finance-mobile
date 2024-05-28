import 'package:finance_mobile/src/features/finance/screens/cadastro/cadastro.dart';
import 'package:finance_mobile/src/features/finance/screens/finance_home/finance_home.dart';
import 'package:flutter/material.dart';

class ResumoScreen extends StatefulWidget {
  static const String id = 'resumo_screen';

  const ResumoScreen({super.key});

  @override
  State<ResumoScreen> createState() => _ResumoScreenState();
}

class _ResumoScreenState extends State<ResumoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF373737),
          ),
          Container(
            padding: EdgeInsets.only(top: 110),
            alignment: Alignment.topCenter,
            height: 200.0,
            decoration: BoxDecoration(
              color: Color(0xFF227E74),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Text(
              'Gráfico de Transações',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NavigationBar(),
            ],
          )
        ],
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.0,
      width: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color(0xFF696969),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Icon(Icons.list, color: Colors.white),
            onTap: () {
              Navigator.pushNamed(context, FinanceScreen.id);
            },
          ),
          GestureDetector(
            child: Icon(
              Icons.currency_exchange,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pushNamed(context, CadastroScreen.id);
            },
          ),
          GestureDetector(
            child: Icon(
              Icons.bar_chart,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pushNamed(context, ResumoScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
