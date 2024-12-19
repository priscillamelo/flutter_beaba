import 'dart:math';
import 'package:flutter/material.dart';

class NumeroPorExtenso extends StatefulWidget {
  const NumeroPorExtenso({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _NumeroPorExtensoState createState() => _NumeroPorExtensoState();
}

class _NumeroPorExtensoState extends State<NumeroPorExtenso> {
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
    9: 'nove'
  };
  int numeroAleatorio = 0;
  String respostaUsuario = '';

  void gerarNovoNumero() {
    setState(() {
      numeroAleatorio =
          Random().nextInt(10); // Gera um número aleatório de 0 a 9
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagem do número
              Image.asset(
                  'assets/images/$numeroAleatorio.png'), // Substitua por seus arquivos de imagem
              const SizedBox(height: 20),
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
    );
  }
}
