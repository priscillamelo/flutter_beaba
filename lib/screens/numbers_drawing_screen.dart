import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_beaba/components/drawing_dashed_component.dart';
import 'package:flutter_beaba/components/drawing_processor_component.dart';
import 'package:flutter_beaba/components/widget_to_image.dart';
import 'package:flutter_beaba/components/drawing_user.dart';
import 'package:flutter_beaba/components/feedback_user.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';

class NumbersDrawingScreen extends StatefulWidget {
  const NumbersDrawingScreen({super.key});

  @override
  State<NumbersDrawingScreen> createState() => _NumbersDrawingScreenState();
}

class _NumbersDrawingScreenState extends State<NumbersDrawingScreen> {
  final GlobalKey _paintKey = GlobalKey();

  List<Offset> pointsUser = [];
  ui.Image? numberImage;

  late GlobalKey globalKeyTrace;
  late GlobalKey globalKeyUser;

  int currentNumberIndex = 0;
  final List<String> numbers = List.generate(10, (index) => index.toString());

  bool said = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await DrawingProcessorComponent.captureImageLetterTrace(globalKeyTrace);
      await TextToSpeechComponent.setAwaitOptions();
      await TextToSpeechComponent.speak("Vamos desenhar os números!");
      await _speakNumber();
    });
  }

  Future<void> _speakNumber() async {
    if (!said) {
      TextToSpeechComponent.speak(
        "Desenhe o número: ${numbers[currentNumberIndex]}",
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
        backgroundColor: Color.fromARGB(255, 123, 207, 252),
        title: Text(
          "Números",
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => pointsUser.clear()),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image:
                AssetImage('assets/images/backgrounds/numbers-background.png'),
            fit: BoxFit.fill,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Stack(
                  children: [
                    WidgetToImage(onImageBuilder: (key) {
                      globalKeyTrace = key;
                      return Center(
                        child: CustomPaint(
                          size: const Size(500, 500),
                          painter: DrawingDashedComponent(
                            shape: null,
                            letter: null,
                            number: numbers[currentNumberIndex],
                          ),
                        ),
                      );
                    }),
                    WidgetToImage(onImageBuilder: (key) {
                      globalKeyUser = key;
                      return GestureDetector(
                        onPanUpdate: (details) {
                          if (_paintKey.currentContext != null) {
                            final RenderBox renderBox =
                                _paintKey.currentContext!.findRenderObject()
                                    as RenderBox;
                            final Offset localOffset =
                                renderBox.globalToLocal(details.globalPosition);

                            setState(() {
                              pointsUser.add(localOffset);
                            });
                          } else {
                            throw Exception(
                                'Erro: _paintKey.currentContext é nulo');
                          }
                        },
                        onPanEnd: (details) {
                          setState(() {
                            pointsUser.add(Offset.zero);
                          });
                        },
                        child: Center(
                          child: CustomPaint(
                            key: _paintKey,
                            size: const Size(500, 500),
                            painter: DrawingUser(
                              points: pointsUser,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                    side: WidgetStatePropertyAll(BorderSide(
                      width: 2,
                      color: Colors.black,
                    )),
                    padding: WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    ),
                  ),
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
                    if (winner) _checkLastNumber();
                    _speakNumber();
                  },
                  child: Text(
                    'Verificar Número',
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
                  )),
            ],
          ),
        );
      }),
    );
  }

  void _checkLastNumber() {
    if (currentNumberIndex < numbers.length - 1) {
      setState(() {
        currentNumberIndex++;
        pointsUser.clear(); // Limpa o desenho
      });
    } else {
      _resetGame(); // Reinicia ao completar o alfabeto
    }
  }

  // Função para reiniciar o jogo
  void _resetGame() {
    setState(() {
      currentNumberIndex = 0;
      pointsUser.clear();
    });
  }
}
