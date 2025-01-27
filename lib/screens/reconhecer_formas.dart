import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class ReconhecerFormas extends StatefulWidget {
  const ReconhecerFormas({super.key});

  @override
  State<ReconhecerFormas> createState() => _ReconhecerFormasState();
}

class _ReconhecerFormasState extends State<ReconhecerFormas> {
  final List<String> letras = [
    'circulo.png',
    'exagono.png',
    'octagono.png',
    'pentagono.png',
    'quadrado.png',
    'retangulo.png',
    'triangulo.png',
  ];

  late String imagemAleatoria; // Imagem da primeira linha
  late List<String> segundaLinha;
  String imagemFeedback = ''; // Caminho da imagem de feedback
  int pontuacao = 0; // Pontuação inicial
  final CountDownController _countDownController =
      CountDownController(); // Controlador do cronômetro do jogo
  Color backgroundColor = Colors.blue.shade600; // Cor inicial do fundo

  @override
  void initState() {
    super.initState();
    _inicializarJogo();
  }

  void _inicializarJogo() {
    setState(() {
      imagemAleatoria = letras[Random().nextInt(letras.length)];
      segundaLinha = [imagemAleatoria];
      while (segundaLinha.length < 3) {
        String imagem = letras[Random().nextInt(letras.length)];
        if (!segundaLinha.contains(imagem)) {
          segundaLinha.add(imagem);
        }
      }
      segundaLinha.shuffle();
      imagemFeedback = ''; // Limpa feedback anterior
      backgroundColor = Colors.blue.shade600; // Reseta cor de fundo
    });
  }

  void validarEscolha(String escolha) {
    setState(() {
      if (escolha == imagemAleatoria) {
        imagemFeedback = 'assets/images/letras_ma/acertou2.png';
        pontuacao += 10;
        backgroundColor = const Color.fromARGB(
            255, 19, 199, 25); // Muda fundo para verde no acerto
      } else {
        imagemFeedback = 'assets/images/letras_ma/errou2.png';
        pontuacao -= 5;
        if (pontuacao < 0) pontuacao = 0;
        backgroundColor = const Color.fromARGB(
            255, 231, 28, 13); // Muda fundo para vermelho no erro
      }
    });

    // Reseta o fundo para azul e inicializa o próximo jogo após 1 segundo
    Future.delayed(const Duration(seconds: 1), () {
      _inicializarJogo();
    });
  }

  void _mostrarFimDoJogo() {
    showDialog(
      context: context,
      barrierDismissible: false, // Impede fechar ao clicar fora
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Fim do Jogo!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: Text(
            "Sua pontuação final é $pontuacao.",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                setState(() {
                  pontuacao = 0; // Reinicia a pontuação
                  _countDownController.restart(); // Reinicia o cronômetro
                  _inicializarJogo(); // Reinicia o jogo
                });
              },
              child: const Text("Jogar Novamente"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Volta para a tela anterior
              },
              child: const Text("Sair"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 100, // Aumenta a altura do AppBar
        title: Text(
          '\n Reconhecer \n     Formas',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 7,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color.fromARGB(255, 247, 237, 243),
                  Color.fromARGB(255, 248, 246, 242),
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 243, 241, 247),
                ],
              ).createShader(
                const Rect.fromLTWH(30, 300, 400, 500),
              ),
            shadows: [
              Shadow(
                offset: Offset(0, 0),
                blurRadius: 10,
                color: Colors.white.withAlpha(180), // Efeito de brilho
              ),
              Shadow(
                offset: Offset(0, 3),
                blurRadius: 10,
                color: Colors.blue.withAlpha(150), // Brilho adicional em azul
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor, // Sincroniza com o fundo
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Pontuação: $pontuacao',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 98, 59),
                      Color.fromARGB(255, 255, 184, 77),
                      Color.fromARGB(255, 223, 252, 58),
                      Color.fromARGB(255, 235, 255, 57),
                    ],
                  ).createShader(
                    const Rect.fromLTWH(20, 30, 40, 90),
                  ),
                shadows: [
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    color:
                        Colors.white.withValues(alpha: 0.7), // Efeito de brilho
                  ),
                  Shadow(
                    offset: Offset(0, 3),
                    blurRadius: 10,
                    color: Colors.blue
                        .withValues(alpha: 0.6), // Brilho adicional em azul
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CircularCountDownTimer(
                duration: 20, // Duração de 20 segundos
                initialDuration: 0,
                controller: _countDownController,
                width: _getSize(screenWidth, 0.25),
                height: _getSize(screenWidth, 0.25),
                ringColor: const Color.fromARGB(255, 230, 54, 54),
                fillColor: Colors.blue[100]!,
                backgroundColor: Colors.blue[400],
                strokeWidth: 10.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                  fontSize: _getTextSize(screenWidth, 0.12),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                isReverse: true,
                onComplete: _mostrarFimDoJogo,
              ),
            ),
            Image.asset(
              'assets/images/formas1/$imagemAleatoria',
              width: _getSize(screenWidth, 0.7),
              height: _getSize(screenHeight, 0.3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: segundaLinha.map((imagem) {
                return ElevatedButton(
                  onPressed: () => validarEscolha(imagem),
                  child: Image.asset(
                    'assets/images/formas2/$imagem',
                    width: _getSize(screenWidth, 0.16),
                    height: _getSize(screenHeight, 0.12),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  double _getTextSize(double screenWidth, double ratio) => screenWidth * ratio;
  double _getSize(double size, double ratio) =>
      size.clamp(100.0, double.infinity) * ratio;
}
