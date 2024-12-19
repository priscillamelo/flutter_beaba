import 'dart:math';

import 'package:flutter/material.dart';

class AbcPath {
  static Map<String, Path> letterPaths = {
    'A': Path()
      ..moveTo(100, 80) // topo
      ..lineTo(40, 200) // fim da linha esquerda
      ..moveTo(100, 80) // topo
      ..lineTo(160, 200) // fim da linha direita
      ..moveTo(70, 150) // inicio do meio
      ..lineTo(132, 150) // fim do meio
    /* ..lineTo(150, 150)
      ..moveTo(75, 100)
      ..lineTo(125, 100) */
    ,
    'B': Path()
      ..moveTo(30, 0)
      ..lineTo(30, 180)
      ..moveTo(30, 0)
      ..arcToPoint(
        const Offset(100, 90),
        radius: const Radius.circular(20),
        clockwise: true,
      )
      ..moveTo(30, 90)
      ..lineTo(100, 90)
      ..moveTo(100, 90)
      ..arcToPoint(
        const Offset(30, 180),
        radius: const Radius.circular(20),
        clockwise: true,
      ),

    'C': Path()
      ..moveTo(100, 10)
      ..addArc(const Rect.fromLTRB(50, 50, 100, 100), pi / 2, pi * 2)
      ..arcToPoint(
        const Offset(100, 190),
        radius: const Radius.circular(80),
        clockwise: false,
      ),

    // Adicione outras letras aqui

    'D': Path()
      ..moveTo(40, 0)
      ..lineTo(40, 200)
      ..moveTo(40, 0)
      ..arcToPoint(
        const Offset(40, 200),
        radius: const Radius.circular(20),
        clockwise: true,
      ),

    'P': Path()
      ..moveTo(40, 0)
      ..lineTo(40, 200)
      ..moveTo(40, 0)
      ..arcToPoint(
        const Offset(100, 100),
        radius: const Radius.circular(20),
        clockwise: true,
      )
      ..moveTo(40, 100)
      ..arcToPoint(
        const Offset(100, 100),
        radius: const Radius.circular(50),
        clockwise: false,
      ),
  };
}
