import 'package:flutter/material.dart';
import 'package:flutter_beaba/routes/screen_routes.dart';
import 'package:flutter_beaba/screens/abc_drawing_screen.dart';
import 'package:flutter_beaba/screens/colors_screen.dart';
import 'package:flutter_beaba/screens/curiosidades.dart';
import 'package:flutter_beaba/screens/drawing_screen_shapes.dart';
import 'package:flutter_beaba/screens/recognize_alphabet_libras.dart';
import 'package:flutter_beaba/screens/learn_sign_language.dart';
import 'package:flutter_beaba/screens/menu_screen.dart';
import 'package:flutter_beaba/screens/numbers_drawing_screen.dart';
import 'package:flutter_beaba/screens/recognize_colors_screen.dart';
import 'package:flutter_beaba/screens/reconhecer_formas.dart';
import 'package:flutter_beaba/screens/reconhecer_letras.dart';
import 'package:flutter_beaba/screens/reconhecer_numeros.dart';
import 'package:flutter_beaba/screens/word_formation_screen.dart';

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
      ),
      home: Scaffold(
        body: const MenuScreen(),
      ),
      routes: {
        ScreenRoutes.kMenu: (context) => const MenuScreen(),
        ScreenRoutes.kAbcDrawingScreen: (context) => const AbcDrawingScreen(),
        ScreenRoutes.kNumbersDrawingScreen: (context) =>
            const NumbersDrawingScreen(),
        ScreenRoutes.kShapesDrawingScreen: (context) => const DrawingScreen(),
        ScreenRoutes.kRecognizeLettersScreen: (context) =>
            const ReconhecerLetras(),
        ScreenRoutes.kRecognizeNumbersScreen: (context) =>
            const ReconhecerNumeroPorExtenso(),
        ScreenRoutes.kRecognizeShapesScreen: (context) =>
            const ReconhecerFormas(),
        ScreenRoutes.kRecognizeColorsScreen: (context) =>
            RecognizeColorsScreen(),
        ScreenRoutes.kColorMatchingScreen: (context) =>
            const ColorMatchingScreen(),
        ScreenRoutes.kLearnSignLanguageScreen: (context) => LearnSignLanguage(),
        ScreenRoutes.kIdentifyAlphabetLibras: (context) =>
            RecognizeAlphabetLibras(),
        ScreenRoutes.kWordFormationScreen: (context) =>
            const WordFormationScreen(),
        ScreenRoutes.kCuriosidadesScreen: (context) =>
            const CuriosidadesScreen(),
      },
    );
  }
}
