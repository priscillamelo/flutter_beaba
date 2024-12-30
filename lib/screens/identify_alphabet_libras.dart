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
    setState(() {});
  }

  void _checkAnswer(String selectedLetter) {
    setState(() {
      if (selectedLetter == currentLetter) {
        feedbackMessage = 'Correto!';
        Future.delayed(const Duration(seconds: 2), () {
          feedbackMessage = '';
          _generateNewQuestion();
        });
      } else {
        feedbackMessage = 'Tente novamente';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identifique a letra em libras'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Qual é a letra deste sinal?',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/alphabet_libras/$currentLetter.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: options
                  .map((letter) => ElevatedButton(
                        onPressed: () => _checkAnswer(letter),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: isCorrect && letter == currentLetter
                              ? Colors.green
                              : Colors.blue,
                          padding: const EdgeInsets.all(20),
                        ),
                        child: Text(
                          letter,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Text(
              feedbackMessage,
              style: TextStyle(
                  fontSize: 24, color: isCorrect ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
