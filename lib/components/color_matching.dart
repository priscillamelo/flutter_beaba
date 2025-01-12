import 'package:flutter_beaba/models/colors.dart';
import 'package:flutter/material.dart';

class ColorMatching extends StatefulWidget {
  const ColorMatching({super.key});

  @override
  State<ColorMatching> createState() => _ColorMatchingState();
}

class _ColorMatchingState extends State<ColorMatching> {
  Color vermelho = MinhasCores().vermelho;
  Color amarelo = MinhasCores().amarelo;
  Color laranja = MinhasCores().laranja;
  Color cinza = const Color.fromARGB(255, 66, 66, 66);
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: vermelho,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('vermelho')
                ],
              ),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: amarelo,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('amarelo')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Text(
              '=',
              style: TextStyle(fontSize: 35),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? laranja : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  // padding: EdgeInsets.zero,
                  animationDuration: Duration.zero,
                ),
              ),
              Visibility(
                  visible: isSelected,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Text('laranja'),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Combinacao2 extends StatefulWidget {
  const Combinacao2({super.key});

  @override
  State<Combinacao2> createState() => _Combinacao2State();
}

class _Combinacao2State extends State<Combinacao2> {
  Color azul = MinhasCores().azul;
  Color amarelo = MinhasCores().amarelo;
  Color verde = MinhasCores().verde;
  Color cinza = const Color.fromARGB(255, 66, 66, 66);
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: azul,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('azul')
                ],
              ),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: amarelo,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('amarelo')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Text(
              '=',
              style: TextStyle(fontSize: 35),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? verde : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  // padding: EdgeInsets.zero,
                  animationDuration: Duration.zero,
                ),
              ),
              Visibility(
                  visible: isSelected,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Text('verde'),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Combinacao3 extends StatefulWidget {
  const Combinacao3({super.key});

  @override
  State<Combinacao3> createState() => _Combinacao3State();
}

class _Combinacao3State extends State<Combinacao3> {
  Color azul = MinhasCores().azul;
  Color vermelho = MinhasCores().vermelho;
  Color violeta = MinhasCores().roxo;
  Color cinza = const Color.fromARGB(255, 66, 66, 66);
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: azul,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('azul')
                ],
              ),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: vermelho,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('vermelho')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Text(
              '=',
              style: TextStyle(fontSize: 35),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? violeta : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  // padding: EdgeInsets.zero,
                  animationDuration: Duration.zero,
                ),
              ),
              Visibility(
                  visible: isSelected,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Text('roxo'),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Combinacao4 extends StatefulWidget {
  const Combinacao4({super.key});

  @override
  State<Combinacao4> createState() => _Combinacao4State();
}

class _Combinacao4State extends State<Combinacao4> {
  Color verde = MinhasCores().verde;
  Color amarelo = MinhasCores().amarelo;
  Color verdeAmarelo = MinhasCores().verdeAmarelo;
  Color cinza = const Color.fromARGB(255, 66, 66, 66);
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: verde,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('verde')
                ],
              ),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: amarelo,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('amarelo')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Text(
              '=',
              style: TextStyle(fontSize: 35),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? verdeAmarelo : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  // padding: EdgeInsets.zero,
                  animationDuration: Duration.zero,
                ),
              ),
              Visibility(
                  visible: isSelected,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Text('verde amarelado'),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Combinacao5 extends StatefulWidget {
  const Combinacao5({super.key});

  @override
  State<Combinacao5> createState() => _Combinacao5State();
}

class _Combinacao5State extends State<Combinacao5> {
  Color azul = MinhasCores().azul;
  Color verde = MinhasCores().verde;
  Color verdeAzul = MinhasCores().verdeAzul;
  Color cinza = const Color.fromARGB(255, 66, 66, 66);
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: verde,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('verde')
                ],
              ),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: azul,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('azul')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Text(
              '=',
              style: TextStyle(fontSize: 35),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? verdeAzul : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  // padding: EdgeInsets.zero,
                  animationDuration: Duration.zero,
                ),
              ),
              Visibility(
                  visible: isSelected,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Text('cerceta'),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Combinacao6 extends StatefulWidget {
  const Combinacao6({super.key});

  @override
  State<Combinacao6> createState() => _Combinacao6State();
}

class _Combinacao6State extends State<Combinacao6> {
  Color azul = MinhasCores().azul;
  Color roxoAzul = MinhasCores().roxoAzul;
  Color violeta = MinhasCores().roxo;
  Color cinza = const Color.fromARGB(255, 66, 66, 66);
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: violeta,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('roxo')
                ],
              ),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: azul,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('azul')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Text(
              '=',
              style: TextStyle(fontSize: 35),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? roxoAzul : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  // padding: EdgeInsets.zero,
                  animationDuration: Duration.zero,
                ),
              ),
              Visibility(
                  visible: isSelected,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Text('indigo'),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Combinacao7 extends StatefulWidget {
  const Combinacao7({super.key});

  @override
  State<Combinacao7> createState() => _Combinacao7State();
}

class _Combinacao7State extends State<Combinacao7> {
  Color violeta = MinhasCores().roxo;
  Color vermelho = MinhasCores().vermelho;
  Color roxoVermelho = MinhasCores().roxoVermelho;
  Color cinza = const Color.fromARGB(255, 66, 66, 66);
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: violeta,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('roxo')
                ],
              ),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: vermelho,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('vermelho')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Text(
              '=',
              style: TextStyle(fontSize: 35),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? roxoVermelho : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  // padding: EdgeInsets.zero,
                  animationDuration: Duration.zero,
                ),
              ),
              Visibility(
                  visible: isSelected,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Text('magenta escuro'),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Combinacao8 extends StatefulWidget {
  const Combinacao8({super.key});

  @override
  State<Combinacao8> createState() => _Combinacao8State();
}

class _Combinacao8State extends State<Combinacao8> {
  Color laranja = MinhasCores().laranja;
  Color vermelho = MinhasCores().vermelho;
  Color laranjaVermelho = MinhasCores().laranjaVermelho;
  Color cinza = const Color.fromARGB(255, 66, 66, 66);
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: laranja,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('laranja')
                ],
              ),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: vermelho,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('vermelho')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Text(
              '=',
              style: TextStyle(fontSize: 35),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? laranjaVermelho : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  // padding: EdgeInsets.zero,
                  animationDuration: Duration.zero,
                ),
              ),
              Visibility(
                  visible: isSelected,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Text('laranja avermelhado'),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Combinacao9 extends StatefulWidget {
  const Combinacao9({super.key});

  @override
  State<Combinacao9> createState() => _Combinacao9State();
}

class _Combinacao9State extends State<Combinacao9> {
  Color laranja = MinhasCores().laranja;
  Color amarelo = MinhasCores().amarelo;
  Color laranjaAmarelo = MinhasCores().laranjaAmarelo;
  Color cinza = const Color.fromARGB(255, 66, 66, 66);
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: laranja,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('laranja')
                ],
              ),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash-sem-fundo.png',
                    height: 150,
                    width: 150,
                    color: amarelo,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('amarelo')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Text(
              '=',
              style: TextStyle(fontSize: 35),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? laranjaAmarelo : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  // padding: EdgeInsets.zero,
                  animationDuration: Duration.zero,
                ),
              ),
              Visibility(
                  visible: isSelected,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Text('amarelo ouro'),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
