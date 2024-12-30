import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_beaba/components/drawing_dashed_component.dart';
import 'package:flutter_beaba/components/drawing_processor_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/drawing_user.dart';
import 'package:flutter_beaba/components/widget_to_image.dart';

class NumbersDrawingScreen extends StatefulWidget {
  const NumbersDrawingScreen({super.key});

  @override
  State<NumbersDrawingScreen> createState() => _NumbersDrawingScreenState();
}

class _NumbersDrawingScreenState extends State<NumbersDrawingScreen> {
  final Image imageBackground = Image.asset('assets/images/quadro_drawing.png');
  final GlobalKey _paintKey = GlobalKey();

  List<Offset> pointsUser = [];
  ui.Image? numberImage;

  late GlobalKey globalKeyTrace;
  late GlobalKey globalKeyUser;

  int currentNumberIndex = 0;
  final List<String> numbers = List.generate(10, (index) => index.toString());

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
        title:
            Text('Números', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => pointsUser.clear()),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Vamos desenhar os números!',
                style: Theme.of(context).textTheme.headlineMedium),
            Center(
              child: Stack(
                children: [
                  WidgetToImage(onImageBuilder: (key) {
                    globalKeyTrace = key;
                    return Center(
                      child: CustomPaint(
                        size: const Size(500, 500),
                        painter: DrawingDashedComponent(
                          letter: null,
                          number: numbers[currentNumberIndex],
                        ),
                      ),
                    );
                  }),
                  Center(child: imageBackground),
                  WidgetToImage(onImageBuilder: (key) {
                    globalKeyUser = key;
                    return GestureDetector(
                      onPanUpdate: (details) {
                        if (_paintKey.currentContext != null) {
                          final RenderBox renderBox = _paintKey.currentContext!
                              .findRenderObject() as RenderBox;
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
                    if (currentNumberIndex < numbers.length - 1) {
                      setState(() {
                        currentNumberIndex++;
                        pointsUser.clear(); // Limpa o desenho
                      });
                    } else {
                      _resetGame(); // Reinicia ao completar o alfabeto
                    }
                  }
                  _showDialogImage(winner);
                },
                child: Text(
                  'Próximo Número',
                  style: Theme.of(context).textTheme.displayMedium,
                )),
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text('Reiniciar Jogo'),
            ),
          ],
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
      currentNumberIndex = 0;
      pointsUser.clear();
    });
  }
}
