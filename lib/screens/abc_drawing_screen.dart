import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_beaba/components/drawing_dashed_component.dart';
import 'package:flutter_beaba/components/drawing_processor_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/drawing_user.dart';
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
  final List<String> alphabet =
      List.generate(26, (index) => String.fromCharCode(65 + index)); // A-Z

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await DrawingProcessorComponent.captureImageLetterTrace(globalKeyTrace);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: COLOCAR A MESMA COR DO BACKGROUND IMAGE
        backgroundColor: Colors.yellow.shade300,
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
              /* Text(
                'Vamos desenhar o alfabeto!',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 59, 180),
                        Color.fromARGB(255, 255, 184, 77),
                        Color.fromARGB(255, 43, 177, 255),
                        Color.fromARGB(255, 116, 57, 255),
                      ],
                    ).createShader(
                      const Rect.fromLTWH(30, 300, 400, 500),
                    ),
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ), */
              Center(
                child: Stack(
                  children: [
                    WidgetToImage(onImageBuilder: (key) {
                      globalKeyTrace = key;
                      return Center(
                        child: CustomPaint(
                          size: const Size(500, 500),
                          painter: DrawingDashedComponent(
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
              /* ElevatedButton(
                  style: const ButtonStyle(
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
                    'Próxima letra',
                    style: Theme.of(context).textTheme.displayMedium,
                  )),
              ElevatedButton(
                onPressed: _resetGame,
                child: const Text('Reiniciar Jogo'),
              ), */
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
