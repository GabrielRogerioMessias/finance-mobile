import 'package:finance_mobile/src/features/authentication/screens/Login/login.dart';
import 'package:finance_mobile/src/features/authentication/screens/register/register.dart';
import 'package:finance_mobile/src/features/authentication/screens/resetPassword/reset_password.dart';
import 'package:finance_mobile/src/features/authentication/screens/splash/splash_screen.dart';
import 'package:finance_mobile/src/features/finance/screens/cadastro/cadastro.dart';
import 'package:finance_mobile/src/features/finance/screens/finance_home/finance_home.dart';
import 'package:finance_mobile/src/features/finance/screens/resumo/resumo.dart';
import 'package:finance_mobile/src/features/provider/user_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserIdProvider(),
    child: const MyApp(),
    ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
        FinanceScreen.id: (context) => FinanceScreen(),
        CadastroScreen.id: (context) => CadastroScreen(),
        ResumoScreen.id: (context) => ResumoScreen(),
      },
    );
  }
}
