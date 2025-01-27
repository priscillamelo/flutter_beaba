import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_beaba/components/drawing_dashed_component.dart';
import 'package:flutter_beaba/components/drawing_processor_component.dart';
import 'package:flutter_beaba/components/drawing_user.dart';
import 'package:flutter_beaba/components/widget_to_image.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';
import 'package:flutter_beaba/components/feedback_user.dart';

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
  bool said = false;

  int contList = 2;
  final List<String> shapes = [
    'circulo',
    'triangulo',
    'quadrado',
    'pentagono',
    'estrela'
  ];
  final Map<String, String> shapesGenders = {
    'círculo': 'o',
    'triângulo': 'o',
    'quadrado': 'o',
    'pentágono': 'o',
    'estrela': 'a',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await DrawingProcessorComponent.captureImageLetterTrace(globalKeyTrace);
      await TextToSpeechComponent.setAwaitOptions();
      await TextToSpeechComponent.speak(
          "Vamos desenhar as formas geométricas!");
      await _speakLetter();
    });
  }

  Future<void> _speakLetter() async {
    String shape = shapesGenders.keys.elementAt(contList);
    String article = shapesGenders.values.elementAt(contList);
    if (!said) {
      TextToSpeechComponent.speak(
        "Desenhe $article $shape",
      );
      setState(() {
        said = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 225, 247, 152),
        title: Text(
          'FORMAS GEOMÉTRICAS',
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                          size: const Size(400, 400),
                          painter: DrawingUser(
                            points: pointsUser,
                            color: Colors.blue,
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
                  late bool winner;

                  Uint8List imageTrace =
                      await DrawingProcessorComponent.captureImageLetterTrace(
                          globalKeyTrace);
                  Uint8List imageUser =
                      await DrawingProcessorComponent.captureImageLetterUser(
                          globalKeyUser);
                  setState(() {
                    winner = DrawingProcessorComponent.compareImages(
                        imageTrace, imageUser);
                  });

                  if (context.mounted) {
                    await FeedbackUser.feedbackDrawing(
                        context: context, winner: winner);
                  }
                  if (context.mounted) {
                    late String title;
                    late String content;
                    if (winner) {
                      title = "Parabéns, você acertou!";
                      content = 'assets/images/winner.png';
                    } else {
                      title = "Humm, vamos tentar novamente!";
                      content = 'assets/images/loser.png';
                    }
                    await FeedbackUser.showDialogFeedback(
                      context: context,
                      title: Text(title),
                      content: Image.asset(content),
                    );
                  }
                  setState(() {
                    pointsUser.clear();
                    said = false;
                  });
                  if (winner) _checkLastShapeGeometric();
                  _speakLetter();
                },
                child: Text(
                  'Verificar Forma',
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

  void _checkLastShapeGeometric() {
    if (contList < shapes.length - 1) {
      setState(() {
        contList++;
        pointsUser.clear(); // Limpa o desenho
      });
    } else {
      _resetGame(); // Reinicia ao completar as formas
    }
  }

  void _resetGame() {
    setState(() {
      contList = 0;
      pointsUser.clear();
    });
  }
}
