import 'package:finance_mobile/src/features/authentication/screens/Login/login.dart';
import 'package:finance_mobile/src/features/authentication/screens/register/register.dart';
import 'package:finance_mobile/src/features/authentication/screens/resetPassword/reset_password.dart';
import 'package:finance_mobile/src/features/authentication/screens/splash/splash_screen.dart';
import 'package:finance_mobile/src/features/finance/finance_home/finance_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        SplashScreen.id : (context) => SplashScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegisterScreen.id : (context) => RegisterScreen(),
        HomePage.id : (context) => HomePage(),
        ResetPasswordScreen.id : (context) => ResetPasswordScreen(),
      },
      );
  }
}
// MaterialApp(
// theme: ThemeData(fontFamily: 'Montserrat'),
// debugShowCheckedModeBanner: false,