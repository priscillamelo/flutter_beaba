import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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

  late String imagemAleatoria; // ***Imagem da primeira linha
  late List<String> segundaLinha;
  String imagemFeedback = ''; // ***Caminho da imagem de feedback
  int pontuacao = 0; // ***Pontuação inicial

  final CountDownController _countDownController =
      CountDownController(); // ***Vai controlar o cronômetro do jogo

  @override
  void initState() {
    //***Aqui o jogo é inicializado
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
      imagemFeedback = ''; // ***Limpa feedback anterior
    });
  }

  void validarEscolha(String escolha) {
    setState(() {
      if (escolha == imagemAleatoria) {
        imagemFeedback =
            'assets/images/letras_ma/acertou2.png'; // ***Caminho da imagem de acerto
        pontuacao += 10; // ***Adiciona 10 pontos no acerto
      } else {
        imagemFeedback =
            'assets/images/letras_ma/errou2.png'; // ***Caminho da imagem de erro
        pontuacao -= 5; // ***Remove 5 pontos no erro
        if (pontuacao < 0) pontuacao = 0; // ***Evita pontuação negativa
      }
    });

    Future.delayed(const Duration(seconds: 1), _inicializarJogo);
  }

  void _mostrarFimDoJogo() {
    showDialog(
      context: context,
      barrierDismissible: false, // ***Impede fechar ao clicar fora
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
                Navigator.pop(context); // ***Fecha o diálogo
                setState(() {
                  pontuacao = 0; // ***Reinicia a pontuação
                  _countDownController.restart(); // ***Reinicia o cronômetro
                  _inicializarJogo(); // ***Reinicia o jogo
                });
              },
              child: const Text("Jogar Novamente"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // ***Volta para a tela anterior
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
      backgroundColor: Colors.blue.shade600,
      appBar: AppBar(
        title: Text(
          'Reconhecer Formas',
          style: GoogleFonts.ubuntuMono(
            fontSize: _getTextSize(screenWidth, 0.075),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pontuação: $pontuacao',
              style: GoogleFonts.ubuntuMono(
                fontSize: _getTextSize(screenWidth, 0.08),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CircularCountDownTimer(
                duration: 20, // Duração de 1 minuto
                initialDuration: 0,
                controller: _countDownController,
                width: _getSize(screenWidth, 0.2),
                height: _getSize(screenWidth, 0.2),
                ringColor: Colors.grey[300]!,
                fillColor: Colors.blue[100]!,
                backgroundColor: Colors.blue[400],
                strokeWidth: 10.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                  fontSize: _getTextSize(screenWidth, 0.08),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                isReverse: true,
                onComplete: _mostrarFimDoJogo,
              ),
            ),
            Image.asset(
              'assets/images/formas1/$imagemAleatoria',
              width: _getSize(screenWidth, 0.4),
              height: _getSize(screenHeight, 0.3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: segundaLinha.map((imagem) {
                return ElevatedButton(
                  onPressed: () => validarEscolha(imagem),
                  child: Image.asset(
                    'assets/images/formas2/$imagem',
                    width: _getSize(screenWidth, 0.2),
                    height: _getSize(screenHeight, 0.15),
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
