import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_beaba/components/feedback_user.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';

class ReconhecerNumeroPorExtenso extends StatefulWidget {
  const ReconhecerNumeroPorExtenso({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ReconhecerNumeroPorExtensoState createState() =>
      _ReconhecerNumeroPorExtensoState();
}

class _ReconhecerNumeroPorExtensoState
    extends State<ReconhecerNumeroPorExtenso> {
  final Map<int, String> numerosPorExtenso = {
    0: 'Zero',
    1: 'Um',
    2: 'Dois',
    3: 'Três',
    4: 'Quatro',
    5: 'Cinco',
    6: 'Seis',
    7: 'Sete',
    8: 'Oito',
    9: 'Nove',
    10: 'Dez',
    11: 'Onze',
    12: 'Doze',
    13: 'Treze',
    14: 'Catorze',
    15: 'Quinze',
    16: 'Dezesseis',
    17: 'Dezessete',
    18: 'Dezoito',
    19: 'Dezenove',
    20: 'Vinte',
  };

  late int numeroAleatorio;
  late List<int> opcoes;

  @override
  void initState() {
    super.initState();
    numeroAleatorio = Random().nextInt(20);
    opcoes = [
      numeroAleatorio,
      Random().nextInt(20),
      Random().nextInt(20),
    ];
    opcoes.shuffle();
  }

  void gerarNovoNumero() {
    setState(() {
      for (var i = 0; i < opcoes.length; i++) {
        numeroAleatorio = Random().nextInt(20);
        opcoes[i] = numeroAleatorio;
      }
      opcoes.shuffle();
    });
  }

  Future<void> _speakLetter() async {
    TextToSpeechComponent.speak(
      "Qual é o número: $numeroAleatorio",
    );
  }

  @override
  Widget build(BuildContext context) {
    _speakLetter();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 255, 133),
        title: const Text('QUAL É O NÚMERO?'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 141, 255, 133),
                  Color.fromARGB(100, 59, 248, 247)
                ]),
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/backgrounds/reconhecer_numeros_bg_certa.png'),
                fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 16.0,
                  left: 16.0,
                  bottom: 40,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${numerosPorExtenso[numeroAleatorio]}',
                        style: TextStyle(
                          fontSize: 52,
                        ),
                      ),
                      Spacer(flex: 1),
                      Wrap(
                        spacing: 24,
                        children: opcoes
                            .map((number) => FilledButton(
                                  style: ButtonStyle(
                                    minimumSize: WidgetStatePropertyAll(
                                      Size(90, 100),
                                    ),
                                  ),
                                  onPressed: () async {
                                    bool isCorrect = number == numeroAleatorio;
                                    await FeedbackUser.feedbackRecognize(
                                        isCorrect);

                                    if (isCorrect) gerarNovoNumero();
                                  },
                                  child: Text(
                                    '$number',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ))
                            .toList(),
                      ),
                    ]),
              ),
            ),
          ),
        );
      }),
    );
  }
}
