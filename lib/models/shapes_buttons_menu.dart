import 'package:flutter/material.dart';

class SquareClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Arredondando os cantos do quadrado com um raio de 20 (você pode ajustar esse valor)
    double radius = 20.0;
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(radius)));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: size.center(Offset.zero), radius: size.width / 2));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double width = size.width;
    final double height = size.height;

    path.moveTo(width / 2, 0); // Topo
    path.lineTo(width, height / 2); // Lado direito
    path.lineTo(width / 2, height); // Base
    path.lineTo(0, height / 2); // Lado esquerdo
    path.close(); // Fecha o losango

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class PentagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(width / 2, 0); // Top
    path.lineTo(0, height * 0.4); // Top left
    path.lineTo(width * 0.2, height); // Bottom left
    path.lineTo(width * 0.8, height); // Bottom right
    path.lineTo(width, height * 0.4); // Top right
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(width * 0.5, 0); // Top center
    path.lineTo(0, height * 0.25); // Top left
    path.lineTo(0, height * 0.75); // Bottom left
    path.lineTo(width * 0.5, height); // Bottom center
    path.lineTo(width, height * 0.75); // Bottom right
    path.lineTo(width, height * 0.25); // Top right
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OctagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;
    final double cornerSize = width * 0.2; // Tamanho dos cantos do octógono

    Path path = Path()
      ..moveTo(cornerSize, 0) // Começa no canto superior esquerdo
      ..lineTo(width - cornerSize, 0) // Linha superior
      ..lineTo(width, cornerSize) // Canto superior direito
      ..lineTo(width, height - cornerSize) // Linha direita
      ..lineTo(width - cornerSize, height) // Canto inferior direito
      ..lineTo(cornerSize, height) // Linha inferior
      ..lineTo(0, height - cornerSize) // Canto inferior esquerdo
      ..lineTo(0, cornerSize) // Linha esquerda
      ..close(); // Fecha o caminho

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Aqui, a largura e altura são ajustadas para garantir uma forma oval
    double width = size.width;
    double height =
        size.height * 0.85; // Ajuste para criar um oval mais alongado

    path.addOval(Rect.fromLTWH(0, 0, width, height));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
