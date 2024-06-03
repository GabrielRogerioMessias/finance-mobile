import 'package:finance_mobile/src/features/finance/models/transacao_model.dart';
import 'package:finance_mobile/src/features/finance/screens/finance_home/widgets/header_finance.dart';
import 'package:finance_mobile/src/features/finance/screens/finance_home/widgets/title_transacoes.dart';
import 'package:finance_mobile/src/features/finance/screens/update_transacao/update_transacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_mobile/src/features/provider/user_id_provider.dart';
import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/finance/widgets/custom_navigation_botton_bar.dart';

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

  double somaReceitas = 0.0;
  double somaDespesas = 0.0;
  double saldoTotal = 0.0;

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
        _calcularValores();
      });
    }
  }

  void _calcularValores() {
    double receitas = 0.0;
    double despesas = 0.0;

    for (var transacao in transacoes) {
      if (transacao.tipoTransacao) {
        receitas += transacao.valorEntrada;
      } else {
        despesas += transacao.valorEntrada;
      }
    }

    setState(() {
      somaReceitas = receitas;
      somaDespesas = despesas;
      saldoTotal = receitas - despesas;
    });
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, Transacao transaction) async {
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
                DatabaseHelper.instance
                    .deleteTransaction(transaction.transacaoId);
                _calcularValores();
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
          SingleChildScrollView(
            child: Column(
              children: [
                HeaderFinanceHome(
                    userName: userName,
                    somaReceitas: somaReceitas,
                    somaDespesas: somaDespesas,
                    saldoTotal: saldoTotal,),
                SizedBox(
                  height: 10,
                ),
                TitleTransacoes(),
                if (transacoes.isNotEmpty)
                  Container(
                    height: 400,
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: ListView.builder(
                      itemCount: transacoes.length,
                      itemBuilder: (context, index) {
                        final transaction = transacoes[index];
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 14.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF4B4B4B),
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
                                          // Descrição
                                          '${transaction.descricao}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // Categoria
                                        Text(
                                            '${categoriasNome[transaction.categoriaId]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            // Valor
                                            Text(
                                              ' R\$${transaction.valorEntrada}',
                                              style: TextStyle(
                                                  color: transaction.tipoTransacao
                                                      ? Color(0xFF3CB6A9)
                                                      : Color(0xFFE83838),
                                                  fontSize: 22),
                                            ),
                                            //Data
                                            Text(
                                              '${transaction.dataEntrada}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () =>
                                                  _showDeleteConfirmationDialog(
                                                      context, transaction),
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateTransacao(
                                                            transaction:
                                                            transaction),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
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
                SizedBox(height: 10,),
                CustomBottomNavigationBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

