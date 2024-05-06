import 'package:finance_mobile/src/features/finance/screens/cadastro/cadastro.dart';
import 'package:finance_mobile/src/features/finance/screens/resumo/resumo.dart';
import 'package:finance_mobile/src/features/provider/user_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinanceScreen extends StatefulWidget {
  static const String id = 'finance_screen';

  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserIdProvider>(context).userName;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFF373737),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Color(0xFF227E74),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 14),
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
                      padding: EdgeInsets.only(left: 14.0, bottom: 40),
                      child: Row(
                        children: [
                          Text(
                            'Olá, ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
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
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20,),
                child: Text(
                  'Histórico de Transações',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              Container(
                height: 32.0,
                width: 80.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Color(0xFF696969)),
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
