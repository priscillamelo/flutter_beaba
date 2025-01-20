import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/menu_button_component.dart';
import 'package:flutter_beaba/models/shapes_buttons_menu.dart';
import 'package:flutter_beaba/routes/screen_routes.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/backgrounds/menu-background.jpg',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        MenuWidget()
      ]),
    );
  }
}

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Text(
            'Hora de Aprender!',
            style: TextStyle(
              fontSize: 35,
              fontFamily: 'DynaPuff',
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 59, 180),
                    Color.fromARGB(255, 255, 184, 77),
                    Color.fromARGB(255, 43, 177, 255),
                    Color.fromARGB(255, 116, 57, 255),
                  ],
                ).createShader(
                  const Rect.fromLTWH(30, 300, 400, 500),
                ),
              shadows: [
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  color:
                      Colors.white.withValues(alpha: 0.7), // Efeito de brilho
                ),
                Shadow(
                  offset: Offset(0, 3),
                  blurRadius: 10,
                  color: Colors.blue
                      .withValues(alpha: 0.6), // Brilho adicional em azul
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kAbcDrawingScreen,
                    gif: Image.asset('assets/gifs/menu/menu-abc.gif'),
                    clipper: SquareClipper(),
                    color: Colors.pink.shade100),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kNumbersDrawingScreen,
                    gif: Image.asset('assets/gifs/menu/menu-numbers.gif'),
                    clipper: SquareClipper(),
                    color: Colors.blue.shade100),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kShapesDrawingScreen,
                    gif: Image.asset('assets/gifs/menu/menu-shapes.gif'),
                    clipper: SquareClipper(),
                    color: Colors.green.shade100),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kRecognizeLettersScreen,
                    gif: Image.asset(
                        'assets/gifs/menu/menu-recognize-letters.gif'),
                    clipper: SquareClipper(),
                    color: Colors.green.shade100),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kRecognizeNumbersScreen,
                    gif: Image.asset(
                        'assets/gifs/menu/menu-recognize-numbers.gif'),
                    clipper: SquareClipper(),
                    color: Colors.green.shade100),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kRecognizeShapesScreen,
                    gif: Image.asset(
                        'assets/gifs/menu/menu-recognize-shapes.gif'),
                    clipper: SquareClipper(),
                    color: Colors.green.shade100),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kRecognizeColorsScreen,
                    gif: Image.asset(
                        'assets/gifs/menu/menu-recognize-colors.gif'),
                    clipper: SquareClipper(),
                    color: Colors.deepOrange.shade200),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kColorMatchingScreen,
                    gif: Image.asset(
                        'assets/gifs/menu/menu-colors-matching.gif'),
                    clipper: SquareClipper(),
                    color: Colors.purple.shade100),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kLearnSignLanguageScreen,
                    gif: Image.asset(
                        'assets/gifs/menu/menu-learn-sign-language.gif'),
                    clipper: SquareClipper(),
                    color: Colors.amber.shade100),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kIdentifyAlphabetLibras,
                    gif: Image.asset(
                        'assets/gifs/menu/menu-identify-alphabet-libras.gif'),
                    clipper: SquareClipper(),
                    color: Colors.amber.shade100),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kWordFormationScreen,
                    gif:
                        Image.asset('assets/gifs/menu/menu-word-formation.gif'),
                    clipper: SquareClipper(),
                    color: Colors.yellow.shade200),
                MenuButtonComponent.buildCustomButton(
                    context: context,
                    routes: ScreenRoutes.kCuriosidadesScreen,
                    gif: Image.asset('assets/gifs/menu/menu-curiosities.gif'),
                    clipper: SquareClipper(),
                    color: Colors.green.shade100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
