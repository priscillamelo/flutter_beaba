import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/drawing_dashed_component.dart';
import 'package:flutter_beaba/components/drawing_user.dart';
import 'package:flutter_beaba/components/widget_to_image.dart';

// ignore: must_be_immutable
class DrawingComponent extends StatefulWidget {
  final Image imageBackground;
  late GlobalKey globalKeyTrace;
  late GlobalKey globalKeyUser;
  final String? letter;
  final String? number;
  final List<Offset> pointsUser;
  DrawingComponent(
    this.globalKeyTrace,
    this.globalKeyUser, {
    super.key,
    required this.imageBackground,
    required this.letter,
    required this.number,
    required this.pointsUser,
  });

  @override
  State<DrawingComponent> createState() => _DrawingComponentState();

  List<GlobalKey> getGlobalKey() {
    return [globalKeyTrace, globalKeyUser];
  }
}

class _DrawingComponentState extends State<DrawingComponent> {
  final GlobalKey _paintKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Exibe a letra tracejada que a criança deve desenhar
          WidgetToImage(onImageBuilder: (key) {
            widget.globalKeyTrace = key;
            return Center(
              child: CustomPaint(
                key: _paintKey,
                size: const Size(400, 400), // Tamanho fixo do CustomPaint
                painter: DrawingDashedComponent(
                    letter: widget.letter, number: widget.number),
              ),
            );
          }),
          Center(child: widget.imageBackground),

          // Exibe o desenho do usuário
          WidgetToImage(onImageBuilder: (key) {
            widget.globalKeyUser = key;
            return GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  final RenderBox renderBox =
                      _paintKey.currentContext!.findRenderObject() as RenderBox;

                  // Convertendo o toque global para local
                  final Offset localOffset =
                      renderBox.globalToLocal(details.globalPosition);

                  widget.pointsUser.add(localOffset);
                });
              },
              onPanEnd: (details) {
                widget.pointsUser.add(
                    Offset.zero); // Adiciona ponto zero para segmentar linhas
              },
              child: Center(
                child: CustomPaint(
                  size: const Size(400, 400), // Mesmo tamanho do CustomPaint
                  painter: DrawingUser(
                    points: widget.pointsUser,
                    color: Colors.blue,
                    strokeWidth: 10.0,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
