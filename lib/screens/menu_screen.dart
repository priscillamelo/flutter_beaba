import 'package:flutter/material.dart';
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

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 24,
      crossAxisSpacing: 32,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll<Color>(Colors.pink),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
          ),
          onPressed: () {
            Navigator.pushNamed(context, ScreenRoutes.kAbcDrawingScreen);
          },
          child: Image.asset('assets/images/menu/menu_abc.png'),
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll<Color>(Colors.blue),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              )),
            ),
            onPressed: () {
              Navigator.pushNamed(context, ScreenRoutes.kNumbersDrawingScreen);
            },
            child: Image.asset('assets/images/menu/menu_numbers.png')),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  const WidgetStatePropertyAll<Color>(Colors.purple),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              )),
            ),
            onPressed: () {
              Navigator.pushNamed(context, ScreenRoutes.kColorMatchingScreen);
            },
            child: Image.asset('assets/images/menu/menu-colors.png')),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll<Color>(Colors.pink),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              )),
            ),
            onPressed: () {
              Navigator.pushNamed(context, ScreenRoutes.kShapesScreen);
            },
            child: Image.asset('assets/images/menu/menu-shapes.png')),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  const WidgetStatePropertyAll<Color>(Colors.amber),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              )),
            ),
            onPressed: () {},
            child: Image.asset('assets/images/menu/menu_libras.png')),
      ],
    );
  }
}
