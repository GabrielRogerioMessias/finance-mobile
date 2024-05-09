import 'package:finance_mobile/src/features/finance/models/transacao_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_mobile/src/features/provider/user_id_provider.dart';
import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/finance/screens/cadastro/cadastro.dart';
import 'package:finance_mobile/src/features/finance/screens/resumo/resumo.dart';

class FinanceScreen extends StatefulWidget {
  static const String id = 'finance_screen';

  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  List<Transacao> transacoes = [];
  Map<int, String> categoriasNome = {
    1: 'Alimentação',
    2: 'Compras',
    3: 'Contas',
    4: 'Salário',
    5: 'Pix',
  };

  @override
  void initState() {
    super.initState();
    _loadTransacoes();
  }

  Future<void> _loadTransacoes() async {
    int? userId = Provider.of<UserIdProvider>(context, listen: false).userId;
    if (userId != null) {
      List<Map<String, dynamic>> maps =
          await DatabaseHelper.instance.getTransacoesByUserId(userId);
      print('Dados retornados: $maps');
      List<Transacao> transacoes =
          maps.map((map) => Transacao.fromMap(map)).toList();
      setState(() {
        this.transacoes = transacoes;
      });
    }
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, Transacao transaction) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Tem certeza de que deseja excluir esta transação?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                setState(() {
                  transacoes.remove(transaction);
                });
                DatabaseHelper.instance.deleteTransaction(transaction.transacaoId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              HeaderFinanceHome(userName: userName),
              SizedBox(height: 20,),
              TitleTransacoes(),
              if (transacoes.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: transacoes.length,
                    itemBuilder: (context, index) {
                      final transaction = transacoes[index];
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 14.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF696969),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${transaction.descricao}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Descrição
                                      Text(
                                          '${categoriasNome[transaction.categoriaId]}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                      // Categoria
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Valor: ${transaction.valorEntrada}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                      // Valor
                                      Text(
                                        '${transaction.dataEntrada}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            _showDeleteConfirmationDialog(
                                                context, transaction),
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      // Data
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      );
                    },
                  ),
                ),
              NavigationBar(),
            ],
          )
        ],
      ),
    );
  }
}

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

class HeaderFinanceHome extends StatelessWidget {
  const HeaderFinanceHome({
    super.key,
    required this.userName,
  });

  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      margin: EdgeInsets.only(bottom: 50),
      height: 32.0,
      width: 80.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0), color: Color(0xFF696969)),
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
