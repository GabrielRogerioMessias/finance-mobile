import 'package:finance_mobile/src/features/finance/screens/finance_home/finance_home.dart';
import 'package:finance_mobile/src/features/finance/screens/resumo/resumo.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  static const String id = 'cadastro_screen';

  const CadastroScreen({Key? key}) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();

  //controle de seleçao do botao
  bool _isReceitaSelected = false;
  bool _isDespesaSelected = false;

  void toggleSelection() {
    setState(() {
      _isReceitaSelected = !_isReceitaSelected;
      _isDespesaSelected = !_isReceitaSelected;
    });
  }

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
                  child: Column(
                    children: [
                      cadastroInput(
                          controller: nameController,
                          inputType: TextInputType.text,
                          hint: 'nome'),
                      SizedBox(
                        height: 8.0,
                      ),
                      cadastroInput(
                          controller: precoController,
                          inputType: TextInputType.number,
                          hint: 'preço'),
                      SizedBox(
                        height: 8.0,
                      ),
                      cadastroInput(
                        controller: dataController,
                        inputType: TextInputType.datetime,
                        hint: 'data',
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: _isReceitaSelected
                                      ? Color(0xFF4B4B4B)
                                      : Color(0xFF373737),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  ImageIcon(AssetImage(
                                      'assets/icons/Initiate Money Transfer.png')),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Receita',
                                    style: TextStyle(
                                        color: Color(0xFFBABABA), fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              toggleSelection();
                              print('Receita');
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: _isDespesaSelected
                                      ? Color(0xFF4B4B4B)
                                      : Color(0xFF373737),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage('assets/icons/Request Money.png'),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Despesa',
                                    style: TextStyle(
                                        color: Color(0xFFBABABA), fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              toggleSelection();
                              print('Despesa');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Adicionar',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xFF227E74),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              Size(300, 50),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 180.0),
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

class cadastroInput extends StatelessWidget {
  const cadastroInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.inputType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
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
