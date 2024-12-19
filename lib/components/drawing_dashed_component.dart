import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/models/abc_path.dart';
import 'package:flutter_beaba/models/numbers_path.dart';

class DrawingDashedComponent extends CustomPainter {
  final String? letter;
  final String? number;

  DrawingDashedComponent({required this.letter, required this.number});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Obtenha o caminho da letra do mapa de paths
    final Path? letterPath = letter != null
        ? AbcPath.letterPaths[letter]
        : NumbersPath.numbersPath[number];

    // final Path? letterPath = NumbersPath.numbersPath[letter];

    /*  if (letterPath != null) {
      Path dashedPath = _createDashedPath(letterPath, 5.0, 5.0);
      // Desenhar a letra tracejada
      canvas.drawPath(dashedPath, paint);

    } */
    if (letterPath != null) {
      // Obter os bounds do Path para centralizar
      final Rect bounds = letterPath.getBounds();

      // Centralize o Path no canvas
      final double dx = (size.width - bounds.width) / 2 - bounds.left;
      final double dy = (size.height - bounds.height) - bounds.top;
      canvas.translate(dx, dy);

      // Crie e desenhe o Path tracejado
      Path dashedPath = _createDashedPath(letterPath, 5.0, 5.0);
      canvas.drawPath(dashedPath, paint);
      print(
          'Desenhando ${letter ?? number}, Bounds: ${letterPath.getBounds()}');
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
