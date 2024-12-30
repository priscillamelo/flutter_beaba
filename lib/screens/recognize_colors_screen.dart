import 'package:flutter/material.dart';

class RecognizeColorsScreen extends StatefulWidget {
  const RecognizeColorsScreen({super.key});

  @override
  State<RecognizeColorsScreen> createState() => _RecognizeColorsScreenState();
}

class _RecognizeColorsScreenState extends State<RecognizeColorsScreen> {
  final Map<String, Color> colors = {
    "Vermelho": Colors.red,
    "Azul": Colors.blue,
    "Amarelo": Colors.yellow,
    "Verde": Colors.green,
    "Laranja": Colors.orange,
    "Roxo": Colors.purple,
  };

  late String targetColorName; // Nome da cor correta
  late Color targetColor; // Cor correta
  List<String> options = []; // Opções para o jogador

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reconhecer Cores"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Qual é a cor: $targetColorName?",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: options.map((colorName) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors[colorName], // Cor do botão
                      minimumSize: Size(100, 50),
                    ),
                    onPressed: () => _checkAnswer(colorName),
                    child: Text(
                      colorName,
                      style: TextStyle(color: Colors.white, fontSize: 16),
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

  void _generateQuestion() {
    // Gera a cor alvo
    final randomColorEntry = colors.entries.toList()..shuffle();
    targetColorName = randomColorEntry.first.key;
    targetColor = randomColorEntry.first.value;

    // Gera opções de resposta
    options = colors.keys.toList()..shuffle();
    setState(() {});
  }

  void _checkAnswer(String selectedColor) {
    if (selectedColor == targetColorName) {
      _showResultDialog(true);
    } else {
      _showResultDialog(false);
    }
  }

  void _showResultDialog(bool isCorrect) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? "Parabéns!" : "Tente novamente!"),
        content: Text(isCorrect
            ? "Você acertou a cor $targetColorName!"
            : "A cor correta era $targetColorName."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _generateQuestion();
            },
            child: Text("Continuar"),
          ),
        ],
      ),
    );
  }
}
