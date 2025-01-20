import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_beaba/components/drawing_dashed_component.dart';
import 'package:flutter_beaba/components/drawing_processor_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/drawing_user.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';
import 'package:flutter_beaba/components/widget_to_image.dart';

class AbcDrawingScreen extends StatefulWidget {
  const AbcDrawingScreen({super.key});

  @override
  State<AbcDrawingScreen> createState() => _AbcDrawingScreenState();
}

class _AbcDrawingScreenState extends State<AbcDrawingScreen> {
  final GlobalKey _paintKey = GlobalKey();

  List<Offset> pointsUser = [];
  ui.Image? letterImage;

  late GlobalKey globalKeyTrace;
  late GlobalKey globalKeyUser;

  int currentLetterIndex = 0;
  bool said = false;
  final List<String> alphabet =
      List.generate(26, (index) => String.fromCharCode(65 + index)); // A-Z

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await DrawingProcessorComponent.captureImageLetterTrace(globalKeyTrace);
    });
    TextToSpeechComponent.speak("Vamos desenhar o alfabeto!");
  }

  @override
  Widget build(BuildContext context) {
    if (said == false) {
      TextToSpeechComponent.speak(
          "Desenha a letra: ${alphabet[currentLetterIndex]}");
      setState(() {
        said = true;
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 244, 235, 132),
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
            image: AssetImage('assets/images/backgrounds/abc-background.jpg'),
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
                            letter: alphabet[currentLetterIndex],
                            number: null,
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
                              strokeWidth: 10.0,
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

                  if (winner == true) {
                    if (currentLetterIndex < alphabet.length - 1) {
                      setState(() {
                        currentLetterIndex++;
                        pointsUser.clear(); // Limpa o desenho
                      });
                    } else {
                      _resetGame(); // Reinicia ao completar o alfabeto
                    }
                  }
                  _showDialogImage(winner);
                },
                child: Text(
                  'Verificar letra',
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
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Função para mostrar o diálogo com o resultado
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
                    said = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  // Função para reiniciar o jogo
  void _resetGame() {
    setState(() {
      currentLetterIndex = 0;
      pointsUser.clear();
    });
  }
}
