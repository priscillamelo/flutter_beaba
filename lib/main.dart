import 'package:flutter/material.dart';
import 'package:flutter_beaba/routes/screen_routes.dart';
import 'package:flutter_beaba/screens/abc_drawing_screen.dart';
import 'package:flutter_beaba/screens/colors_screen.dart';
import 'package:flutter_beaba/screens/drawing_screen_shapes.dart';
import 'package:flutter_beaba/screens/identify_alphabet_libras.dart';
import 'package:flutter_beaba/screens/menu_screen.dart';
import 'package:flutter_beaba/screens/numbers_drawing_screen.dart';
import 'package:flutter_beaba/screens/recognize_colors_screen.dart';
import 'package:flutter_beaba/screens/reconhecer_formas.dart';

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
            toolbarHeight: 70,
            backgroundColor: Colors.lightBlue.shade100,
            centerTitle: true,
            title: Image.asset(
              'assets/images/logo.png',
              height: 60,
            ),
          ),
          body: const MenuScreen()),
      routes: {
        ScreenRoutes.kMenu: (context) => const MenuScreen(),
        ScreenRoutes.kAbcDrawingScreen: (context) => const AbcDrawingScreen(),
        ScreenRoutes.kNumbersDrawingScreen: (context) =>
            const NumbersDrawingScreen(),
        //ScreenRoutes.kShapesScreen: (context) => const DrawingScreen(),
        ScreenRoutes.kShapesScreen: (context) => const ReconhecerFormas(),
        ScreenRoutes.kRecognizeColorsScreen: (context) =>
            RecognizeColorsScreen(),
        ScreenRoutes.kColorMatchingScreen: (context) =>
            const TelaCombinacaoCores(),
        ScreenRoutes.kIdentifyAlphabetLibras: (context) =>
            IdentifyAlphabetLibras(),
      },
    );
  }
}
