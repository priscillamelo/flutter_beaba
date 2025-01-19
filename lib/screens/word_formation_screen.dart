import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/container_component.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';
import 'dart:math';
import 'package:flutter_beaba/models/word_formation.dart';

class WordFormationScreen extends StatefulWidget {
  const WordFormationScreen({super.key});

  @override
  State<WordFormationScreen> createState() => _WordFormationScreenState();
}

class _WordFormationScreenState extends State<WordFormationScreen> {
  late String chosenWord;
  late String imageWord;
  late int level;
  Map<String, String> listWords = {};
  List<String> listWordsCopy = [];
  List<String> letters = [];
  List<String?> slots = [];

  @override
  void initState() {
    super.initState();
    TextToSpeechComponent.speak("Vamos formar palavras!");

    level = 1;
    startGame();
  }

  void startGame() {
    if (level == 1) {
      listWords = WordFormation.level1;
    } else {
      listWords = WordFormation.level2;
    }
    generateNewWord(listWords);

    setState(() {
      letters = chosenWord.split('')..shuffle();
      slots = List<String?>.filled(chosenWord.length, null);
    });
    TextToSpeechComponent.speak("Forme a palavra: $chosenWord");
  }

  void generateNewWord(Map<String, String> listWords) {
    do {
      int randomIndex = Random().nextInt(listWords.length);
      chosenWord = listWords.keys.elementAt(randomIndex);
      imageWord = listWords.values.elementAt(randomIndex);
    } while (listWordsCopy.contains(chosenWord));
  }

  void checkIfWordIsCorrect() {
    late String feedbackMessage;
    late String feedbackTitle;
    late String textButton;

    if (slots.join('') == chosenWord) {
      feedbackTitle = "Parabéns!";
      feedbackMessage = "Você formou a palavra corretamente! 🎉";
      textButton = "Próxima rodada";
      listWordsCopy.add(chosenWord);

      if (listWordsCopy.length == listWords.length) {
        listWordsCopy.clear();
        level++;
      }
    } else {
      feedbackTitle = "Humm...";
      feedbackMessage = "Você não acertou. Vamos tentar outra palavra?";
      textButton = "Jogar novamente";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feedbackTitle),
        content: Text(feedbackMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              startGame();
            },
            child: Text(textButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F5F5),
      appBar: AppBar(
        title: Text('Forme a Palavra'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/word_formation/$imageWord.png',
                width: 200,
                height: 200,
              ),
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: slots.asMap().entries.map((entry) {
                  final index = entry.key;
                  String? letter = entry.value;
                  if (letter != null) letter = letter.toUpperCase();
                  return DragTarget<String>(
                    onWillAcceptWithDetails: (details) {
                      return slots[index] == null;
                    },
                    onAcceptWithDetails: (details) {
                      setState(() {
                        slots[index] = details.data;
                        letters.remove(details.data);
                      });
                      if (letters.isEmpty) checkIfWordIsCorrect();
                    },
                    builder: (context, candidateData, rejectedData) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (slots[index] != null) {
                              letters.add(slots[index]!);
                              slots[index] = null;
                            }
                          });
                        },
                        child: ContainerComponent(
                          letter: letter,
                          colorBackground:
                              letter == null ? Colors.blueGrey : Colors.pink,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: letters.map((letter) {
                  return Draggable<String>(
                    data: letter,
                    feedback: Material(
                      color: Colors.transparent,
                      child: ContainerComponent(
                        letter: letter.toUpperCase(),
                        colorBackground: Colors.pink,
                      ),
                    ),
                    childWhenDragging: SizedBox(
                      width: 50,
                      height: 50,
                    ),
                    child: ContainerComponent(
                      letter: letter.toUpperCase(),
                      colorBackground: Colors.lightGreen,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
