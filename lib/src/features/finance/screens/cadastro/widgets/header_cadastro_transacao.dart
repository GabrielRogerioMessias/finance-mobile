import 'package:finance_mobile/src/features/provider/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderCadastroTransacao extends StatelessWidget {
  const HeaderCadastroTransacao({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 14, top: 50),
          child: IconButton(
            onPressed: () {
              Provider.of<ScreenProvider>(context, listen: false)
                  .currentScreen = 0;
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Cadastro de transações',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ],
    );
  }
}
