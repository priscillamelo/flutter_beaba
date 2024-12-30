import 'package:flutter/material.dart';

class MenuButtonComponent {
  static Widget buildCustomButton({
    required BuildContext context,
    required String routes,
    required Image gif,
    required CustomClipper<Path> clipper,
    required Color color,
  }) {
    return ClipPath(
      clipper: clipper,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Cor do botão
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0)), // Remove bordas arredondadas
        ),
        onPressed: () {
          Navigator.pushNamed(context, routes);
        },
        child: Center(
          child: gif,
        ),
      ),
    );
  }
}
