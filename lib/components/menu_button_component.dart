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
        style: ButtonStyle(
          side: WidgetStatePropertyAll(BorderSide(
              color: Colors.white38, style: BorderStyle.solid, width: 3)),
          backgroundColor: WidgetStatePropertyAll(color),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          ),
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
