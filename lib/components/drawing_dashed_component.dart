import 'package:flutter/material.dart';

class DrawingDashedComponent extends CustomPainter {
  final String? letter;
  final String? number;

  DrawingDashedComponent({required this.letter, required this.number});

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: letter != null ? letter! : number!,
        style: TextStyle(
          fontFamily: 'NationalFirstFontDotted',
          fontSize: 250,
          color: Colors.red,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Centraliza o texto no canvas
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 1.7,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
