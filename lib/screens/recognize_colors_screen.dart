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
        title: Text(
          'Qual é a cor?',
          style: TextStyle(
            fontSize: 32,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color.fromARGB(255, 135, 25, 108),
                  Color.fromARGB(255, 71, 37, 102),
                  Color.fromARGB(255, 2, 32, 76),
                ],
              ).createShader(
                const Rect.fromLTWH(30, 300, 400, 500),
              ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 246, 174, 230),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/backgrounds/recognize-colors-background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  targetColorName,
                  style: TextStyle(
                    color: Colors.black87,
                    letterSpacing: 4,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: 24,
                  runSpacing: 32,
                  children: options.map((colorName) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(CircleBorder(
                            side: BorderSide(color: Colors.black, width: 2))),
                        backgroundColor: WidgetStatePropertyAll(
                            colors[colorName]), // Cor do botão
                        minimumSize: WidgetStatePropertyAll(Size(100, 100)),
                      ),
                      onPressed: () => _checkAnswer(colorName),
                      child: null,
                    );
                  }).toList(),
                ),
              ],
            ),
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
        title: Text(isCorrect
            ? 'Parabéns! Você conseguiu!!'
            : 'Hummm... Vamos tentar novamente!'),
        content: Image.asset(
            isCorrect ? 'assets/images/winner.png' : 'assets/images/loser.png'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (isCorrect) _generateQuestion();
            },
            child: Text("Continuar"),
          ),
        ],
      ),
    );
  }
}
