import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_beaba/components/text_to_speech_component.dart';
import 'package:flutter_beaba/models/colors_matching.dart';

class ColorMatchingScreen extends StatefulWidget {
  const ColorMatchingScreen({super.key});

  @override
  State<ColorMatchingScreen> createState() => _ColorMatchingScreenState();
}

class _ColorMatchingScreenState extends State<ColorMatchingScreen> {
  late int combinacao;
  @override
  void initState() {
    super.initState();
    combinacao = Random().nextInt(combinacoes.length);
    TextToSpeechComponent.speak("Descubra as combinações das cores!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 231, 172),
        title: const Text(
          'COMBINAÇÕES DAS CORES',
          style: TextStyle(
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 231, 172),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Descubra a combinação dessas cores',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    combinacoes[combinacao],
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                      ),
                      onPressed: () {
                        setState(() {
                          combinacao = Random().nextInt(combinacoes.length);
                        });
                      },
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 3, 158),
                              Color.fromARGB(255, 255, 153, 0),
                              Color.fromARGB(255, 0, 162, 255),
                              Color.fromARGB(255, 76, 0, 255),
                            ],
                          ).createShader(bounds);
                        },
                        child: const Text(
                          'Ver outra combinação',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
