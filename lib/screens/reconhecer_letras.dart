import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ReconhecerLetras extends StatefulWidget {
  const ReconhecerLetras({super.key});

  @override
  State<ReconhecerLetras> createState() => _ReconhecerLetrasState();
}

class _ReconhecerLetrasState extends State<ReconhecerLetras> {
  final List<String> letras = [
    'a.png',
    'b.png',
    'c.png',
    'd.png',
    'e.png',
    'f.png',
    'g.png',
    'h.png',
    'i.png',
    'j.png',
    'k.png',
    'l.png',
    'm.png',
    'n.png',
    'o.png',
    'p.png',
    'q.png',
    'r.png',
    's.png',
    't.png',
    'u.png',
    'v.png',
    'x.png',
    'w.png',
    'y.png'
  ];

  late String imagemAleatoria;
  late List<String> segundaLinha;
  String imagemFeedback = '';
  int pontuacao = 0;

  final CountDownController _countDownController = CountDownController();
  Color backgroundColor = Colors.blue.shade600; // Cor inicial do fundo
  Color appBarColor = Colors.blue.shade600; // Cor inicial do AppBar

  @override
  void initState() {
    super.initState();
    _inicializarJogo();
  }

  void _inicializarJogo() {
    setState(() {
      imagemAleatoria = letras[Random().nextInt(letras.length)];
      segundaLinha = [imagemAleatoria];
      while (segundaLinha.length < 4) {
        String imagem = letras[Random().nextInt(letras.length)];
        if (!segundaLinha.contains(imagem)) {
          segundaLinha.add(imagem);
        }
      }
      segundaLinha.shuffle();
      imagemFeedback = '';
      backgroundColor = Colors.blue.shade600; // Reseta cor de fundo
      appBarColor = Colors.blue.shade600; // Reseta cor do AppBar
    });
  }

  void validarEscolha(String escolha) {
    setState(() {
      if (escolha == imagemAleatoria) {
        imagemFeedback = 'assets/images/letras_ma/acertou2.png';
        pontuacao += 10;
        backgroundColor = const Color.fromARGB(255, 19, 199, 25); // Fundo verde no acerto
        appBarColor = const Color.fromARGB(255, 19, 199, 25); // AppBar verde no acerto
      } else {
        imagemFeedback = 'assets/images/letras_ma/errou2.png';
        pontuacao -= 5;
        if (pontuacao < 0) pontuacao = 0;
        backgroundColor = const Color.fromARGB(255, 233, 32, 18); // Fundo vermelho no erro
        appBarColor = const Color.fromARGB(255, 231, 28, 13); // AppBar vermelho no erro
      }
    });

    // Reseta fundo e AppBar após 1 segundo
    Future.delayed(const Duration(seconds: 1), _inicializarJogo);
  }

  void _mostrarFimDoJogo() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Fim do Jogo!",
            style: GoogleFonts.ubuntuMono(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: Text(
            "Sua pontuação final é $pontuacao.",
            style: GoogleFonts.ubuntuMono(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  pontuacao = 0;
                  _countDownController.restart();
                  _inicializarJogo();
                });
              },
              child: const Text("Jogar Novamente"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
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
      fontFamily: 'DynaPuff',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
            'Pontuação: $pontuacao',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'DynaPuff',
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
                duration: 20,
                initialDuration: 0,
                controller: _countDownController,
                width: _getSize(screenWidth, 0.2),
                height: _getSize(screenWidth, 0.2),
                ringColor: const Color.fromARGB(255, 123, 10, 168)!,
                fillColor: Colors.blue[100]!,
                backgroundColor: Colors.blue[400],
                strokeWidth: 10.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                  fontSize: _getTextSize(screenWidth, 0.05),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                isReverse: true,
                onComplete: _mostrarFimDoJogo,
              ),
            ),
            Image.asset(
              'assets/images/letras_ma/$imagemAleatoria',
              width: _getSize(screenWidth, 0.4),
              height: _getSize(screenHeight, 0.3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: segundaLinha.map((imagem) {
                return ElevatedButton(
                  onPressed: () => validarEscolha(imagem),
                  child: Image.asset(
                    'assets/images/letras_mi/$imagem',
                    width: _getSize(screenWidth, 0.1),
                    height: _getSize(screenHeight, 0.1),
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
