import 'package:flutter/material.dart';
import 'package:flutter_beaba/routes/screen_routes.dart';
import 'package:flutter_beaba/screens/abc_drawing_screen.dart';
import 'package:flutter_beaba/screens/colors_screen.dart';
import 'package:flutter_beaba/screens/drawing_screen_shapes.dart';
import 'package:flutter_beaba/screens/menu_screen.dart';
import 'package:flutter_beaba/screens/numbers_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DynaPuff',
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: TextStyle(
            fontSize: 54.0,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/images/logo.png',
              height: 80,
            ),
          ),
          body: const MenuScreen()),
      routes: {
        ScreenRoutes.kMenu: (context) => const MenuScreen(),
        ScreenRoutes.kAbcDrawingScreen: (context) => const AbcDrawingScreen(),
        ScreenRoutes.kNumbersDrawingScreen: (context) => const NumbersScreen(),
        ScreenRoutes.kColorMatchingScreen: (context) =>
            const TelaCombinacaoCores(),
        ScreenRoutes.kShapesScreen: (context) => const DrawingScreen(),
      },
    );
  }
}

/* class BemVindoScreen extends StatelessWidget {
  const BemVindoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/papel-de-parede.jpeg'),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 30, 8.0, 8.0),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/personagem.png'),
              const SizedBox(
                height: 100,
              ),
              Container(
                color: Colors.grey,
                child: const Text(
                    style: TextStyle(color: Colors.white),
                    'Olá, seja bem-vindo(a) ao Bê-A-Bá. Muito legal ter você conosco. Aqui nós iremos aprender se divertindo.'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */
