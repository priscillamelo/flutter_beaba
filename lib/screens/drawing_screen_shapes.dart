import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_beaba/components/dashed_shapes_component.dart';
import 'package:flutter_beaba/components/drawing_shape_user.dart';
import 'package:flutter_beaba/components/widget_to_image.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final Image imageBackground = Image.asset('assets/images/quadro_drawing.png');
  final GlobalKey _paintKey = GlobalKey(); // Adiciona um GlobalKey

  List<Offset> pointsUser = [];
  ui.Image? letterImage;

  late GlobalKey globalKeyTrace;
  late GlobalKey globalKeyUser;

  int currentShapeIndex = 2;
  final List<String> shapes = ['circulo', 'triangulo', 'quadrado', 'pentagono'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _captureImageLetterTrace();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formas',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Vamos desenhas as formas!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Center(
              child: Stack(children: [
                // Exibe a forma tracejada que a criança deve desenhar
                WidgetToImage(onImageBuilder: (key) {
                  globalKeyTrace = key;
                  return Center(
                    child: CustomPaint(
                      key: _paintKey, // Adiciona o GlobalKey
                      size: const Size(400, 400), // Tamanho fixo do CustomPaint
                      painter: DashedShapeComponent(
                          shape: shapes[currentShapeIndex]),
                    ),
                  );
                }),
                Center(
                  child: imageBackground,
                ),

                // Área de Desenho (GestureDetector cobrindo tudo)
                WidgetToImage(onImageBuilder: (key) {
                  globalKeyUser = key;
                  return GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        final RenderBox renderBox = _paintKey.currentContext!
                            .findRenderObject() as RenderBox;

                        // Convertendo o toque global para local
                        final Offset localOffset =
                            renderBox.globalToLocal(details.globalPosition);

                        pointsUser.add(localOffset);
                      });
                    },
                    onPanEnd: (details) {
                      pointsUser.add(Offset
                          .zero); // Adiciona ponto zero para segmentar linhas
                    },
                    child: Center(
                      child: CustomPaint(
                        size: const Size(
                            400, 400), // Mesmo tamanho do CustomPaint
                        painter: DrawingShapeUser(
                          points: pointsUser,
                          color: Colors.blue,
                          strokeWidth: 10.0,
                        ),
                      ),
                    ),
                  );
                }),
              ]),
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 20, horizontal: 30))),
                onPressed: () async {
                  Uint8List imageTrace = await _captureImageLetterTrace();
                  Uint8List imageUser = await _captureImageLetterUser();
                  setState(() {
                    _compareImages(imageTrace, imageUser);
                  });
                },
                child: Text(
                  'Proxima Forma',
                  style: Theme.of(context).textTheme.displayMedium,
                )),
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text('Reiniciar jogo'),
            )
          ],
        );
      }),
    );
  }

  Future<Uint8List> _captureImageLetterTrace() async {
    RenderRepaintBoundary? boundary = globalKeyTrace.currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage();

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    return pngBytes!;
  }

  Future<Uint8List> _captureImageLetterUser() async {
    RenderRepaintBoundary? boundary = globalKeyUser.currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage();

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    return pngBytes!;
  }

  void _compareImages(Uint8List imageTrace, Uint8List imageUser) async {
    img.Image? imgTrace = img.decodeImage(imageTrace);
    img.Image? imgUser = img.decodeImage(imageUser);

    if (imgTrace == null || imgUser == null) {
      debugPrint('Erro: Falha ao decodificar uma ou ambas as imagens.');
      return;
    }

    // Calcula os pixels cobertos
    int totalPixels1 = 0;
    int totalPixels2 = 0;
    int coveredPixels = 0;

    for (int y = 0; y < imgUser.height; y++) {
      for (int x = 0; x < imgUser.width; x++) {
        img.Pixel pixelTrace = imgTrace.getPixelSafe(x, y);
        img.Pixel pixelUser = imgUser.getPixelSafe(x, y);

        if (pixelUser.b > 0) {
          totalPixels2++;
          //coveredPixels++;
        }

        // Verifica se o pixel faz parte da letra (cor vermelha, por exemplo)
        if (pixelTrace.r > 0) {
          totalPixels1++;

          // Verifica se o pixel foi coberto (cor do usuário não é transparente)
          if (pixelUser.a > 0) {
            // totalPixels2++;
            coveredPixels++;
          }
        }
      }
    }

    // Calcula a porcentagem de cobertura
    final newCoveragePercentage = (coveredPixels / totalPixels1) * 100;
    bool winner = newCoveragePercentage > 40;

    if (winner == true) {
      if (currentShapeIndex < shapes.length - 1) {
        setState(() {
          currentShapeIndex++;

          pointsUser.clear(); // Limpa o desenho
        });
      } else {
        _resetGame(); // Reinicia ao completar o alfabeto
      }
    }
    _showDialogImage(winner);
  }

  Future<void> _showDialogImage(bool winner) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(winner
                ? 'Parabéns! Você conseguiu!!'
                : 'Hummm... Vamos tentar novamente!'),
            content: Image.asset(winner
                ? 'assets/images/winner.png'
                : 'assets/images/loser.png'),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  setState(() {
                    pointsUser.clear();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _resetGame() {
    setState(() {
      currentShapeIndex = 0;
      pointsUser.clear();
    });
  }
}
