import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/feedback_user.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';

class RecognizeAlphabetLibras extends StatefulWidget {
  const RecognizeAlphabetLibras({super.key});

  @override
  State<RecognizeAlphabetLibras> createState() =>
      _RecognizeAlphabetLibrasState();
}

class _RecognizeAlphabetLibrasState extends State<RecognizeAlphabetLibras> {
  final List<String> alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  late String currentLetter;
  late List<String> options;
  bool isCorrect = false;
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    TextToSpeechComponent.speak("Qual letra do alfabeto esse sinal representa");

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

  void _checkAnswer(String selectedLetter) async {
    bool isCorrect = selectedLetter == currentLetter;

    if (isCorrect) {
      FeedbackUser.feedbackRecognize(isCorrect);
      Future.delayed(
          Duration(milliseconds: 400),
          () => setState(() {
                _generateNewQuestion();
              }));
    } else {
      FeedbackUser.feedbackDrawing(context: context, winner: isCorrect);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QUAL É A LETRA?',
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                            minimumSize: Size(100, 130),
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
