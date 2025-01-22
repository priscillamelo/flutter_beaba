// import 'dart:math';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReconhecerNumeroPorExtenso extends StatefulWidget {
  const ReconhecerNumeroPorExtenso({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ReconhecerNumeroPorExtensoState createState() =>
      _ReconhecerNumeroPorExtensoState();
}

class _ReconhecerNumeroPorExtensoState
    extends State<ReconhecerNumeroPorExtenso> {
  final Map<int, String> numerosPorExtenso = {
    0: 'zero',
    1: 'um',
    2: 'dois',
    3: 'três',
    4: 'quatro',
    5: 'cinco',
    6: 'seis',
    7: 'sete',
    8: 'oito',
    9: 'nove',
    10: 'dez',
    11: 'onze',
    12: 'doze',
    13: 'treze',
    14: 'catorze',
    15: 'quinze',
    16: 'dezesseis',
    17: 'dezessete',
    18: 'dezoito',
    19: 'dezenove',
    20: 'vinte',
  };

  late int numeroAleatorio;
  late List<int> opcoes;

  @override
  void initState() {
    super.initState();
    numeroAleatorio = Random().nextInt(20);
    opcoes = [
      numeroAleatorio,
      Random().nextInt(20),
      Random().nextInt(20),
      Random().nextInt(20)
    ];
    opcoes.shuffle();
  }

  void gerarNovoNumero() {
    setState(() {
      for (var i = 0; i < 4; i++) {
        numeroAleatorio = Random().nextInt(20);
        opcoes[i] = numeroAleatorio;
      }
      opcoes.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 141, 255, 133),
          title: const Text('Identifique os números'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 141, 255, 133),
                      Color.fromARGB(100, 59, 248, 247)
                    ]),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/backgrounds/reconhecer_numeros_bg_certa.png',
                    ),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${numerosPorExtenso[numeroAleatorio]}',
                          style: TextStyle(
                            fontSize: 70,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16,
                          children: [
                            // Text('${opcoes.length}')
                            FilledButton(
                                style: ButtonStyle(
                                    minimumSize:
                                        WidgetStatePropertyAll(Size(60, 60))),
                                onPressed: () {
                                  if (opcoes[0] == numeroAleatorio) {
                                    gerarNovoNumero();
                                    Fluttertoast.showToast(
                                        msg: 'Parabens, você acertou');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Que pena, você errou');
                                  }
                                },
                                child: Text(
                                  '${opcoes[0]}',
                                  style: TextStyle(fontSize: 32),
                                )),
                            FilledButton(
                                style: ButtonStyle(
                                    minimumSize:
                                        WidgetStatePropertyAll(Size(60, 60))),
                                onPressed: () {
                                  if (opcoes[1] == numeroAleatorio) {
                                    gerarNovoNumero();
                                    Fluttertoast.showToast(
                                        msg: 'Parabens, você acertou');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Que pena, você errou');
                                  }
                                },
                                child: Text(
                                  '${opcoes[1]}',
                                  style: TextStyle(fontSize: 32),
                                )),
                            FilledButton(
                                style: ButtonStyle(
                                    minimumSize:
                                        WidgetStatePropertyAll(Size(60, 60))),
                                onPressed: () {
                                  if (opcoes[2] == numeroAleatorio) {
                                    gerarNovoNumero();
                                    Fluttertoast.showToast(
                                        msg: 'Parabens, você acertou');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Que pena, você errou');
                                  }
                                },
                                child: Text(
                                  '${opcoes[2]}',
                                  style: TextStyle(fontSize: 32),
                                )),
                            FilledButton(
                                style: ButtonStyle(
                                    minimumSize:
                                        WidgetStatePropertyAll(Size(60, 60))),
                                onPressed: () {
                                  if (opcoes[3] == numeroAleatorio) {
                                    gerarNovoNumero();
                                    Fluttertoast.showToast(
                                        msg: 'Parabens, você acertou');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Que pena, você errou');
                                  }
                                },
                                child: Text(
                                  '${opcoes[3]}',
                                  style: TextStyle(fontSize: 32),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
