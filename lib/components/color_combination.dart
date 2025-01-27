import 'package:flutter_beaba/models/colors.dart';
import 'package:flutter/material.dart';

class ColorCombination extends StatefulWidget {
  final Cores cor1;
  final Cores cor2;
  final Cores resultColor;

  const ColorCombination({
    super.key,
    required this.cor1,
    required this.cor2,
    required this.resultColor,
  });

  @override
  State<ColorCombination> createState() => _ColorCombinationState();
}

class _ColorCombinationState extends State<ColorCombination> {
  bool isSelected = false;
  final Color cinza = const Color.fromARGB(255, 66, 66, 66);

  @override
  void didUpdateWidget(covariant ColorCombination oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Resetar o estado ao atualizar o widget
    if (widget.resultColor != oldWidget.resultColor) {
      setState(() {
        isSelected = false;
      });
    }
  }

  void _selecionarResultado() {
    setState(() {
      isSelected = true;
    });
  }

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
              _buildColorWidget(widget.cor1),
              const SizedBox(
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              _buildColorWidget(widget.cor2),
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
                onPressed: _selecionarResultado,
                icon: Image.asset(
                  'assets/images/splash-sem-fundo.png',
                  height: 150,
                  width: 150,
                  color: isSelected ? widget.resultColor.cor : cinza,
                ),
                style: IconButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  animationDuration: Duration.zero,
                ),
              ),
              SizedBox(
                height: 20,
                child: Visibility(
                  visible: isSelected,
                  child: Text(widget.resultColor.nome),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorWidget(Cores cor) {
    return Column(
      children: [
        Image.asset(
          'assets/images/splash-sem-fundo.png',
          height: 150,
          width: 150,
          color: cor.cor,
        ),
        const SizedBox(height: 3),
        Text(cor.nome),
      ],
    );
  }
}
