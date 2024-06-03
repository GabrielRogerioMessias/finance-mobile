// src/features/finance/widgets/custom_navigation_botton_bar.dart

import 'package:finance_mobile/src/features/finance/screens/cadastro/cadastro.dart';
import 'package:finance_mobile/src/features/finance/screens/finance_home/finance_home.dart';
import 'package:finance_mobile/src/features/provider/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 // Importe o provider criado

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var currentPage = Provider.of<ScreenProvider>(context).currentScreen;

    return Container(
      margin: EdgeInsets.only(bottom: 50),
      height: 50.0,
      width: 150.0,
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0), color: Color(0xFF4B4B4B)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Column(
              children: [
                Icon(Icons.home, color: currentPage == 0? Color(0xFF3CB6A9) : Colors.white),
                Text('Home', style: TextStyle(color: currentPage == 0? Color(0xFF3CB6A9) : Colors.white, fontWeight: FontWeight.bold),)
              ],
            ),
            onTap: () {
              Provider.of<ScreenProvider>(context, listen: false).currentScreen = 0;
              Navigator.pushNamed(context, FinanceScreen.id);
              // Navegação para FinanceScreen
            },
          ),
          GestureDetector(
            child: Column(
              children: [
                Icon(
                  Icons.currency_exchange,
                  color: currentPage == 1? Color(0xFF3CB6A9) : Colors.white,
                ),
                Text('Cadastro', style: TextStyle(color: currentPage == 1? Color(0xFF3CB6A9) : Colors.white, fontWeight: FontWeight.bold),)
              ],
            ),
            onTap: () {
              Provider.of<ScreenProvider>(context, listen: false).currentScreen = 1;
              Navigator.pushNamed(context, CadastroScreen.id);
              // Navegação para CadastroScreen
            },
          ),
        ],
      ),
    );
  }
}
