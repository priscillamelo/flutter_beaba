import 'package:flutter_beaba/components/color_combination.dart';
import 'package:flutter_beaba/models/colors.dart';

final List<ColorCombination> combinacoes = [
  ColorCombination(
    cor1: Cores.vermelho,
    cor2: Cores.amarelo,
    resultColor: Cores.laranja,
  ),
  ColorCombination(
    cor1: Cores.azul,
    cor2: Cores.amarelo,
    resultColor: Cores.verde,
  ),
  ColorCombination(
    cor1: Cores.azul,
    cor2: Cores.vermelho,
    resultColor: Cores.roxo,
  ),
  ColorCombination(
    cor1: Cores.verde,
    cor2: Cores.amarelo,
    resultColor: Cores.verdeAmarelo,
  ),
  ColorCombination(
    cor1: Cores.azul,
    cor2: Cores.verde,
    resultColor: Cores.verdeAzul,
  ),
  ColorCombination(
    cor1: Cores.azul,
    cor2: Cores.roxo,
    resultColor: Cores.roxoAzul,
  ),
  ColorCombination(
    cor1: Cores.roxo,
    cor2: Cores.vermelho,
    resultColor: Cores.roxoVermelho,
  ),
  ColorCombination(
    cor1: Cores.laranja,
    cor2: Cores.vermelho,
    resultColor: Cores.laranjaVermelho,
  ),
  ColorCombination(
    cor1: Cores.laranja,
    cor2: Cores.amarelo,
    resultColor: Cores.laranjaAmarelo,
  ),
];
