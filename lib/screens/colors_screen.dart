import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/color_matching.dart';

class TelaCombinacaoCores extends StatefulWidget {
  const TelaCombinacaoCores({super.key});

  @override
  State<TelaCombinacaoCores> createState() => _TelaCombinacaoCoresState();
}

class _TelaCombinacaoCoresState extends State<TelaCombinacaoCores> {
  List<Widget> combinacoes = [
    const ColorMatching(),
    const Combinacao2(),
    const Combinacao3(),
    const Combinacao4(),
    const Combinacao5(),
    const Combinacao6(),
    const Combinacao7(),
    const Combinacao8(),
    const Combinacao9(),
  ];
  int combinacao = Random().nextInt(9);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 231, 172),
        title: const Text('Combinações das cores'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 231, 172),
              // image: DecorationImage(
              //   image: AssetImage(
              //       'assets/images/backgrounds/descobrir_comb_cores_bg_certa.png'),
              //   // alignment: Alignment.topCenter,
              //   fit: BoxFit.fitHeight,
              //   alignment: Alignment.topCenter,
              // ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Descubra a combinação dessas cores',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    combinacoes[combinacao],
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          combinacao = Random().nextInt(9);
                        });
                      },
                      child: const Text('Ver outra combinação'),
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
