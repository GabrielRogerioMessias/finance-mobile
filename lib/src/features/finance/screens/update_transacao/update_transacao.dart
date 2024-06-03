import 'package:finance_mobile/src/features/finance/screens/finance_home/finance_home.dart';
import 'package:finance_mobile/src/features/finance/widgets/cadastro_transacoes_input.dart';
import 'package:flutter/material.dart';
import 'package:finance_mobile/src/features/authentication/services/database_helper.dart';
import 'package:finance_mobile/src/features/finance/models/transacao_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:finance_mobile/src/features/provider/user_id_provider.dart';

class UpdateTransacao extends StatefulWidget {
  static const String id = 'update_screen';
  final Transacao transaction;

  const UpdateTransacao({Key? key, required this.transaction}) : super(key: key);

  @override
  State<UpdateTransacao> createState() => _UpdateTransacaoState();
}

class _UpdateTransacaoState extends State<UpdateTransacao> {
  late final TextEditingController _descricaoController;
  late final TextEditingController _valorController;
  String? _categoriaSelecionada;
  late bool _isReceita;

  final Map<String, int> categorias = {
    'Alimentação': 1,
    'Compras': 2,
    'Contas': 3,
    'Salário': 4,
    'Pix': 5,
  };

  @override
  void initState() {
    super.initState();
    _descricaoController = TextEditingController(text: widget.transaction.descricao);
    _valorController = TextEditingController(text: widget.transaction.valorEntrada.toString());
    _isReceita = widget.transaction.tipoTransacao;
    _categoriaSelecionada = categorias.entries.firstWhere((entry) => entry.value == widget.transaction.categoriaId, orElse: () => MapEntry('', 0)).key;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                  'Edição Transação',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              SizedBox(height: 20.0),
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
                      SizedBox(height: 8.0),
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
                      SizedBox(height: 8.0),
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
                          items: categorias.keys.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      RadioListTile<bool>(
                        title: const Text(
                          'Receita',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: true,
                        groupValue: _isReceita,
                        onChanged: (bool? value) {
                          setState(() {
                            _isReceita = value!;
                          });
                        },
                      ),
                      RadioListTile<bool>(
                        title: const Text('Despesa',
                            style: TextStyle(color: Colors.white)),
                        value: false,
                        groupValue: _isReceita,
                        onChanged: (bool? value) {
                          setState(() {
                            _isReceita = value!;
                          });
                        },
                      ),
                      SizedBox(height: 40),
                      Container(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              int? userId = Provider.of<UserIdProvider>(context, listen: false).userId;
                              if (_categoriaSelecionada == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Por favor, selecione uma categoria'),
                                  ),
                                );
                                return;
                              }
                              int categoriaId = categorias[_categoriaSelecionada] ?? 0;

                              Map<String, dynamic> transactionData = {
                                'userId': userId,
                                'descricao': _descricaoController.text,
                                'valor_entrada': double.parse(_valorController.text),
                                'categoriaId': categoriaId,
                                'data_entrada': DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                                'tipo_transacao': _isReceita ? 1 : 0,
                                'transacao_id': widget.transaction.transacaoId,
                              };

                              try {
                                await DatabaseHelper.instance.updateTransaction(transactionData);
                                // String successMessage =
                                //     'Atualização de transação realizada com sucesso:\nDescrição: ${_descricaoController.text}\nValor: ${_valorController.text}\nCategoria: ${_categoriaSelecionada ?? 'N/A'}\nTipo: ${_isReceita ? 'Receita' : 'Despesa'}';
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text(successMessage),
                                //   ),
                                // );
                                Navigator.pushNamed(context, FinanceScreen.id);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Falha ao atualizar transação: $e'),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Atualizar',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Color(0xFF227E74)),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            minimumSize: WidgetStateProperty.all(Size(300, 50)),
                          ),
                        ),
                      ),
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
