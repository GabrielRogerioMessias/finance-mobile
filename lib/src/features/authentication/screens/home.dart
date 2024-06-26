import 'package:finance_mobile/src/constants/text_constants.dart';
import 'package:finance_mobile/src/features/authentication/screens/Login/login.dart';
import 'package:finance_mobile/src/features/authentication/screens/register/register.dart';
import 'package:flutter/material.dart';

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
                    Subtitle(),
                  ],
                ),
              ),
              AccessButtons(),
            ],
          ),
        ],
      ),
    );
  }
}

class AccessButtons extends StatelessWidget {
  const AccessButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double alturaElementosAcima = 250;
    double alturaRestante =
        MediaQuery.of(context).size.height - alturaElementosAcima;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: alturaRestante),
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeImage(),
              AccessButton(
                textLabel: 'Acesse com email',
                iconData: Icons.email,
                actionButton: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem conta?',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
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
      ),
    );
  }
}

class HomeImage extends StatelessWidget {
  const HomeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.0),
      child: Center(
        child: Image(
          image: AssetImage(
            'assets/images/home_image.png',
          ),
        ),
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 25.0),
      child: Text(
        'Inicie sessão para um melhor controle de suas finanças',
        style: TextStyle(
            fontFamily: 'Montserrat', fontSize: 16, color: Colors.white),
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
          Expanded(
              child: Center(
                  child: Text(
            textLabel,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Color(0xFF373737)),
          )))
        ],
      ),
    );
  }
}
