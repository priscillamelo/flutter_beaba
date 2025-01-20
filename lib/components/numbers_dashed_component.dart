import 'package:flutter/material.dart';
import 'package:flutter_beaba/models/numbers_path.dart';

class NumbersDashedComponent extends CustomPainter {
  final String? number;

  NumbersDashedComponent({
    required this.number,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path? numberPath = NumbersPath.numbersPath[number];

    if (numberPath != null) {
      final Rect bounds = numberPath.getBounds();

      // Centralize o Path no canvas
      final double dx = (size.width - bounds.width) / 2 - bounds.left;
      final double dy = (size.height - bounds.height) - bounds.top;
      canvas.translate(dx, dy);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
