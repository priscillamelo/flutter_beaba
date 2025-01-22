import 'package:flutter/material.dart';

class ShapesPaths {
  static Map<String, Path> shapesPaths = {
    'circulo': Path()
      ..addOval(Rect.fromCircle(center: const Offset(50, 50), radius: 90)),
    'triangulo': Path()
      ..moveTo(50, 250)
      ..lineTo(250, 250)
      ..lineTo(150, 50)
      ..close(),
    'quadrado': Path()
      ..moveTo(50, 50)
      ..lineTo(50, 250)
      ..lineTo(250, 250)
      ..lineTo(250, 50)
      ..close(),
    'pentagono': Path()
      // x(+ vai p dir, - vai p esq) y(- vai p cima, + vai p baixo)
      ..moveTo(100, 100) // ponto medio esq
      ..lineTo(200, 20) //ponto superior
      ..lineTo(300, 100) // ponto medio dir
      ..lineTo(250, 200) // ponto inferior dir
      ..lineTo(150, 200) //ponto inferior esq
      ..close(),
    'estrela': Path()
      ..moveTo(150, 200) //ponto inferior esq
      ..lineTo(200, 20) //ponto superior
      ..lineTo(250, 200) // ponto inferior dir
      ..lineTo(100, 100) // ponto medio esq
      ..lineTo(300, 100) // ponto medio dir
      ..close(),
  };
}
