import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/menu_button_component.dart';
import 'package:flutter_beaba/models/shapes_buttons_menu.dart';
import 'package:flutter_beaba/routes/screen_routes.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
          ),
        ),
      ),
      body: const MenuWidget(),
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
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        MenuButtonComponent.buildCustomButton(
            context: context,
            routes: ScreenRoutes.kAbcDrawingScreen,
            gif: Image.asset('assets/gifs/menu/menu-abc.gif'),
            clipper: OctagonClipper(),
            color: Colors.pink.shade100),
        MenuButtonComponent.buildCustomButton(
            context: context,
            routes: ScreenRoutes.kNumbersDrawingScreen,
            gif: Image.asset('assets/gifs/menu/menu-numbers.gif'),
            clipper: HexagonClipper(),
            color: Colors.blue.shade100),
        MenuButtonComponent.buildCustomButton(
            context: context,
            routes: ScreenRoutes.kShapesScreen,
            gif: Image.asset('assets/gifs/menu/menu-shapes.gif'),
            clipper: DiamondClipper(),
            color: Colors.green.shade100),
        MenuButtonComponent.buildCustomButton(
            context: context,
            routes: ScreenRoutes.kRecognizeColorsScreen,
            gif: Image.asset('assets/gifs/menu/menu-recognize-colors.gif'),
            clipper: PentagonClipper(),
            color: Colors.deepOrange.shade200),
        MenuButtonComponent.buildCustomButton(
            context: context,
            routes: ScreenRoutes.kColorMatchingScreen,
            gif: Image.asset('assets/gifs/menu/menu-colors-matching.gif'),
            clipper: SquareClipper(),
            color: Colors.purple.shade100),
        MenuButtonComponent.buildCustomButton(
            context: context,
            routes: ScreenRoutes.kIdentifyAlphabetLibras,
            gif: Image.asset(
                'assets/gifs/menu/menu-identify-alphabet-libras.gif'),
            clipper: OvalClipper(),
            color: Colors.amber.shade100),
      ],
    );
  }
}
