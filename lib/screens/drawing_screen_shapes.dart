import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_beaba/components/drawing_dashed_component.dart';
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
  final GlobalKey _paintKey = GlobalKey(); // Adiciona um GlobalKey

  List<Offset> pointsUser = [];
  ui.Image? letterImage;

  late GlobalKey globalKeyTrace;
  late GlobalKey globalKeyUser;

  int contList = 2;
  final List<String> shapes = [
    'circulo',
    'triangulo',
    'quadrado',
    'pentagono',
    'estrela'
  ];

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
        backgroundColor: Color.fromARGB(255, 225, 247, 152),
        title: Text(
          'Formas',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 225, 247, 152),
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/backgrounds/desenhar_forma_bg_certa.png'),
                alignment: Alignment.topLeft,
                // fit: BoxFit.fitWidth
              )),
          child: Column(
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
                        size:
                            const Size(400, 400), // Tamanho fixo do CustomPaint
                        painter: DrawingDashedComponent(
                            shape: shapes[contList],
                            letter: null,
                            number: null),
                      ),
                    );
                  }),
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
                    // contList++;
                    _compareImages(imageTrace, imageUser);
                  });
                },
                child: Text(
                  'Proxima Forma',
                  style: TextStyle(
                    fontSize: 32,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [
                          ui.Color.fromARGB(255, 255, 3, 158),
                          ui.Color.fromARGB(255, 255, 153, 0),
                          ui.Color.fromARGB(255, 0, 162, 255),
                          ui.Color.fromARGB(255, 76, 0, 255),
                        ],
                      ).createShader(
                        const Rect.fromLTWH(30, 300, 400, 500),
                      ),
                  ),
                  // style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
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
      throw Exception('Erro: Falha ao decodificar uma ou ambas as imagens.');
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

          // talvez aq de pra consertar o bug
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
    bool winner =
        newCoveragePercentage > 40; // && totalPixels2 < totalPixels1 * 3;

    if (winner == true) {
      if (contList < shapes.length - 1) {
        setState(() {
          contList++;

          pointsUser.clear(); // Limpa o desenho
        });
      } else {
        _resetGame(); // Reinicia ao completar as formas
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
      contList = 0;
      pointsUser.clear();
    });
  }
}
