import 'package:flutter/material.dart';

class BottomRegister extends StatelessWidget {
  const BottomRegister({
    super.key,
    required this.register,
  });

  final VoidCallback register;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ao prosseguir, aceito os ',
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () => print('Termos de privacidade'),
                child: Text(
                  'termos de privacidade',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xFF3CB6A9),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF3CB6A9),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            child: Text(
              'Criar Conta',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              register();
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(0xFF3CB6A9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
