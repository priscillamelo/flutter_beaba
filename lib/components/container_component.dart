import 'package:flutter/material.dart';

class ContainerComponent extends StatelessWidget {
  final String? letter;
  final Color colorBackground;
  const ContainerComponent(
      {super.key, required this.letter, required this.colorBackground});

  @override
  Widget build(BuildContext context) {
    final double width = colorBackground == Colors.lightGreen ? 70 : 50;
    final double height = width;

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        letter ?? '',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
