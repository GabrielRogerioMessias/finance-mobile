import 'package:finance_mobile/src/constants/text_constants.dart';
import 'package:finance_mobile/src/features/authentication/screens/Login/login.dart';
import 'package:finance_mobile/src/features/authentication/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF373737),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: 250.0,
                decoration: BoxDecoration(
                  color: Color(0xFF227E74),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 50.0),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('assets/logos/white-logo.png'),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('finance', style: kTitleTextStyle),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 25.0),
                      child: Text(
                        'Inicie sessão para um melhor controle de suas finanças',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 30.0),
                child: Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/home_image.png',
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Column(
                  children: [
                    AccessButton(
                      textLabel: 'Acesse com email',
                      iconData: Icons.email,
                      actionButton: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    AccessButton(
                      textLabel: 'Acesse com google',
                      iconData: FontAwesomeIcons.google,
                      actionButton: () => print('Acesse com google'),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    AccessButton(
                      textLabel: 'Acesse com facebook',
                      iconData: FontAwesomeIcons.facebook,
                      actionButton: () => print('Acessar com facebook'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25.0, top: 10.0),
                      child: Row(
                        children: [
                          Text(
                            'Não tem conta?',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            child: Text(
                              'Fazer Cadastro',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xFF3CB6A9),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF3CB6A9),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, RegisterScreen.id);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AccessButton extends StatelessWidget {
  const AccessButton({
    required this.textLabel,
    this.iconData,
    required this.actionButton,
    super.key,
  });

  final String textLabel;
  final IconData? iconData;
  final Function() actionButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: actionButton,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: Size(double.infinity, 50)),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Color(0xFF373737),
          ),
          SizedBox(
            width: 30.0,
          ),
          Text(
            textLabel,
            style: TextStyle(fontSize: 15, color: Color(0xFF373737)),
          )
        ],
      ),
    );
  }
}
// 227E74
