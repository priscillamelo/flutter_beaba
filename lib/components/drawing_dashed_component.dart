import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_beaba/models/shapes.dart';

class DrawingDashedComponent extends CustomPainter {
  final String? letter;
  final String? number;
  final String? shape;

  DrawingDashedComponent(
      {required this.shape, required this.letter, required this.number});

  @override
  void paint(Canvas canvas, Size size) {
    if (shape == null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: letter != null ? letter! : number!,
          style: TextStyle(
            fontFamily: 'NationalFirstFontDotted',
            fontSize: letter != null ? 300 : 400,
            color: Colors.white,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Centraliza o texto no canvas
      final offset = letter != null
          ? Offset(
              (size.width - textPainter.width) / 1.9,
              (size.height - textPainter.height) / 3,
            )
          : Offset(
              (size.width - textPainter.width) / 1.9,
              (size.height - textPainter.height) / 2,
            );

      textPainter.paint(canvas, offset);
    } else {
      final paint = Paint()
        ..color = const Color.fromARGB(255, 255, 255, 255)
        ..strokeWidth = 8.0
        ..style = PaintingStyle.stroke;

      double centerX = size.width / 2.65;
      double centerY = size.height / 3;

      if (shape == 'circulo') {
        centerY = size.height / 3;
        centerX = size.width / 2.65;
      } else if (shape == 'triangulo') {
        centerX = size.width / 8;
        centerY = size.height / 12;
      } else if (shape == 'quadrado') {
        centerX = size.width / 7.75;
        centerY = size.height / 12;
      } else if (shape == 'pentagono') {
        centerX = size.width / 2000;
        centerY = size.height / 12;
      }

      // Centralize o conteúdo no centro do canvas
      canvas.translate(centerX, centerY);
      // Obtenha o caminho da forma do mapa de paths
      final Path? path = ShapesPaths.shapesPaths[shape];

      if (path != null) {
        // Desenhar a forma tracejada
        Path dashedPath = _createDashedPath(path, 7.0, 7.0);
        canvas.drawPath(dashedPath, paint);
      }
    }
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final Path dashedPath = Path();
    for (PathMetric pathMetric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final double nextDistance = distance + dashWidth;
        dashedPath.addPath(
          pathMetric.extractPath(distance, nextDistance),
          Offset.zero,
        );
        distance = nextDistance + dashSpace;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
