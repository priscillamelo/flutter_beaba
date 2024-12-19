import 'package:flutter/material.dart';

class ShapesPaths {
  static Map<String, Path> shapesPaths = {
    'circulo': Path()
      ..addOval(Rect.fromCircle(center: const Offset(50, 50), radius: 50)),
    'triangulo': Path()
      ..moveTo(50, 50)
      ..lineTo(100, 150)
      ..lineTo(150, 50)
      ..close(),
    'quadrado': Path()
      ..moveTo(50, 50)
      ..lineTo(50, 150)
      ..lineTo(150, 150)
      ..lineTo(150, 50)
      ..close(),
    'pentagono': Path()
      ..moveTo(50, 50)
      ..lineTo(100, 25)
      ..lineTo(150, 50)
      ..lineTo(125, 100)
      ..lineTo(75, 100)
      ..close(),
  };
}
