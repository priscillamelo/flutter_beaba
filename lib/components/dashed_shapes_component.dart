import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/models/shapes.dart';

class DashedShapeComponent extends CustomPainter {
  final String shape;

  DashedShapeComponent({required this.shape});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    print('aaaa ${shape}');
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
