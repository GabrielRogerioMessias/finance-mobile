import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/finance/screens/finance_home/finance_home.dart';
import 'package:finance_mobile/src/features/finance/screens/resumo/resumo.dart';
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
                height: 180.0,
                padding: EdgeInsets.only(top: 110.0),
                decoration: BoxDecoration(
                  color: Color(0xFF227E74),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                child: Text(
                  'Cadastro de transações',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
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
                      cadastroInput(
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
                      cadastroInput(
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
                        width: 190,
                        height: 60,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
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
                      RadioListTile<bool>(
                        title: const Text('Receita', style: TextStyle(color: Colors.white),),
                        value: true,
                        groupValue: _isReceita,
                        onChanged: (bool? value) {
                          setState(() {
                            _isReceita = value!;
                          });
                        },
                      ),
                      RadioListTile<bool>(
                        title: const Text('Despesa', style: TextStyle(color: Colors.white)),
                        value: false,
                        groupValue: _isReceita,
                        onChanged: (bool? value) {
                          setState(() {
                            _isReceita = value!;
                          });
                        },
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
                                'data_entrada':DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                              };
                              try {
                                await DatabaseHelper.instance
                                    .insertTransaction(transactionData);
                                String successMessage =
                                    'Cadastro de transação realizado com sucesso, \nDescrição: ${_descricaoController.text}, \nValor: ${_valorController.text}, \nCategoria: ${_categoriaSelecionada ?? 'N/A'}, \nTipo: ${_isReceita ? 'Receita' : 'Despesa'}';
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$successMessage'),
                                  ),
                                );
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
                            MaterialStateProperty.all(Color(0xFF227E74)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            minimumSize:
                            MaterialStateProperty.all(Size(300, 50)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      NavigationBar(),
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

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
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

class cadastroInput extends StatelessWidget {
  const cadastroInput(
      {Key? key,
        required this.controller,
        required this.hint,
        required this.inputType,
        required this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.black),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint),
    );
  }
}