import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/finance/screens/cadastro/widgets/header_cadastro_transacao.dart';
import 'package:finance_mobile/src/features/finance/screens/finance_home/finance_home.dart';
import 'package:finance_mobile/src/features/finance/widgets/cadastro_transacoes_input.dart';
import 'package:finance_mobile/src/features/finance/widgets/custom_navigation_botton_bar.dart';
import 'package:finance_mobile/src/features/provider/screen_provider.dart';
import 'package:finance_mobile/src/features/provider/user_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CadastroScreen extends StatefulWidget {
  static const String id = 'cadastro_screen';

  const CadastroScreen({Key? key}) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  String? _categoriaSelecionada;
  bool _isReceita = false;

  Map<String, int> categorias = {
    'Alimentação': 1,
    'Compras': 2,
    'Contas': 3,
    'Salário': 4,
    'Pix': 5,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white,),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFF373737),
          ),
          Column(
            children: [
              Container(),
              Container(
                alignment: Alignment.topCenter,
                height: 180.0,
                decoration: BoxDecoration(
                  color: Color(0xFF227E74),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                child: HeaderCadastroTransacao(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CadastroTransacaoInput(
                        hint: 'descrição',
                        controller: _descricaoController,
                        inputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma descrição';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      CadastroTransacaoInput(
                        hint: 'valor',
                        controller: _valorController,
                        inputType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o valor';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: 400,
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: DropdownButton<String>(
                          value: _categoriaSelecionada,
                          icon: Icon(Icons.arrow_downward),
                          hint: Text('Categoria'),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _categoriaSelecionada = newValue;
                            });
                          },
                          items: <String>[
                            'Alimentação',
                            'Compras',
                            'Contas',
                            'Salário',
                            'Pix'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 170,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isReceita = true;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      'assets/icons/Initiate Money Transfer.png',
                                      width: 24,
                                      height: 24),
                                  // Substitua pelo caminho correto da sua imagem
                                  SizedBox(width: 8),
                                  Text('Receita',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isReceita
                                    ? Color(0xFF696969)
                                    : Color(0xFF373737),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                          SizedBox(width: 22),
                          Container(
                            width: 170,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isReceita = false;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/Request Money.png',
                                      width: 24, height: 24),
                                  SizedBox(width: 8),
                                  Text('Despesa',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !_isReceita
                                    ? Color(0xFF696969)
                                    : Color(0xFF373737),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              int? userId = Provider.of<UserIdProvider>(context,
                                      listen: false)
                                  .userId;
                              int? categoriaId =
                                  categorias[_categoriaSelecionada ?? ''];
                              Map<String, dynamic> transactionData = {
                                'userId': userId,
                                'descricao': _descricaoController.text,
                                'valor_entrada':
                                    double.parse(_valorController.text),
                                'categoriaId': categoriaId,
                                'data_entrada': DateFormat('dd/MM/yyyy HH:mm')
                                    .format(DateTime.now()),
                                'tipo_transacao': _isReceita ? 1 : 0,
                              };
                              try {
                                await DatabaseHelper.instance
                                    .insertTransaction(transactionData);
                                // String successMessage =
                                //     'Cadastro de transação realizado com sucesso, \nDescrição: ${_descricaoController.text}, \nValor: ${_valorController.text}, \nCategoria: ${_categoriaSelecionada ?? 'N/A'}, \nTipo: ${_isReceita ? 'Receita' : 'Despesa'}';
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text('$successMessage'),
                                //   ),
                                Provider.of<ScreenProvider>(context,
                                        listen: false)
                                    .currentScreen = 0;
                                Navigator.pushNamed(context, FinanceScreen.id);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Falha ao cadastrar transação'),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Adicionar',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xFF227E74)),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            minimumSize: WidgetStateProperty.all(Size(300, 50)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      CustomBottomNavigationBar(),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
