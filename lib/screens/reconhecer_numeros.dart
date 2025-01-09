import 'dart:math';
import 'package:flutter/material.dart';

class ReconhecerNumeroPorExtenso extends StatefulWidget {
  const ReconhecerNumeroPorExtenso({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ReconhecerNumeroPorExtensoState createState() => _ReconhecerNumeroPorExtensoState();
}

class _ReconhecerNumeroPorExtensoState extends State<ReconhecerNumeroPorExtenso> {
  final Map<int, String> numerosPorExtenso = {
    0: 'zero',
    1: 'um',
    2: 'dois',
    3: 'tres',
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

  int numeroAleatorio = 0;
  String respostaUsuario = '';

  void gerarNovoNumero() {
    setState(() {
      numeroAleatorio = Random().nextInt(20);
    });
  }

  void validarResposta() {
    String respostaCorreta = numerosPorExtenso[numeroAleatorio]!;
    if (respostaUsuario.toLowerCase() == respostaCorreta) {
      // Resposta correta
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Parabéns!'),
            content: const Text('Você acertou!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  gerarNovoNumero();
                },
                child: const Text('Próximo número'),
              ),
            ],
          );
        },
      );
    } else {
      // Resposta incorreta
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Que pena!'),
            content: Text('A resposta correta era: $respostaCorreta'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tentar novamente'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identifique os números'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$numeroAleatorio',
                  style: TextStyle(
                    fontSize: 70,
                  ),
                ),
                const SizedBox(height: 50),
                TextField(
                  onChanged: (value) => respostaUsuario = value,
                  decoration: const InputDecoration(
                    hintText: 'Digite o número por extenso',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: validarResposta,
                  child: const Text('Verificar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
