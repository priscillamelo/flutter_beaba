import 'dart:math';

import 'package:flutter/material.dart';

class IdentifyAlphabetLibras extends StatefulWidget {
  const IdentifyAlphabetLibras({super.key});

  @override
  State<IdentifyAlphabetLibras> createState() => _IdentifyAlphabetLibrasState();
}

class _IdentifyAlphabetLibrasState extends State<IdentifyAlphabetLibras> {
  final List<String> alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  late String currentLetter;
  late List<String> options;
  bool isCorrect = false;
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    _generateNewQuestion();
  }

  void _generateNewQuestion() {
    final random = Random();
    currentLetter = alphabet[random.nextInt(alphabet.length)];
    options = List<String>.from(alphabet)
      ..shuffle()
      ..removeWhere((letter) => letter == currentLetter);
    options = options.take(2).toList(); // Duas opções incorretas
    options.add(currentLetter);
    options.shuffle();
    isCorrect = false;
  }

  void _checkAnswer(String selectedLetter) {
    bool isCorrect = selectedLetter == currentLetter;

    setState(() {
      _showResultDialog(isCorrect);
      if (isCorrect) _generateNewQuestion();
    });
  }

  void _showResultDialog(bool isCorrect) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect
            ? 'Parabéns! Você conseguiu!!'
            : 'Hummm... Vamos tentar novamente!'),
        content: Image.asset(
            isCorrect ? 'assets/images/winner.png' : 'assets/images/loser.png'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Continuar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qual é a letra?'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Qual letra do alfabeto esse sinal representa?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    letterSpacing: 2,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/alphabet_libras/$currentLetter.png',
                width: 200,
                height: 200,
              ),
              Wrap(
                spacing: 24,
                children: options
                    .map((letter) => ElevatedButton(
                          onPressed: () => _checkAnswer(letter),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(32),
                          ),
                          child: Text(
                            letter,
                            style: const TextStyle(
                                fontSize: 32, color: Colors.white),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
