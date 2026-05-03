import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/lista_numeros_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rifa App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/lista': (context) => const ListaNumerosScreen(),
      },
    );
  }
}