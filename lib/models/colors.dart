import 'dart:ui';

import 'package:flutter/material.dart';

enum Cores {
  vermelho(Color.fromARGB(255, 255, 0, 0), "Vermelho"),
  amarelo(Color.fromARGB(255, 255, 255, 0), "Amarelo"),
  azul(Color.fromARGB(255, 0, 0, 255), "Azul"),
  verde(Color.fromARGB(255, 0, 128, 0), "Verde"),
  laranja(Color.fromARGB(255, 255, 166, 0), "Laranja"),
  roxo(Color.fromARGB(255, 128, 0, 128), "Roxo"),
  verdeAmarelo(Color.fromARGB(255, 153, 205, 50), "Verde Amarelado"),
  verdeAzul(Color.fromARGB(255, 0, 128, 128), "Cerceta"),
  roxoVermelho(Color.fromARGB(255, 176, 0, 176), "Magenta"),
  roxoAzul(Color.fromARGB(255, 64, 0, 128), "Índigo"),
  laranjaAmarelo(Color.fromARGB(255, 255, 255, 127), "Amarelo Ouro"),
  laranjaVermelho(Color.fromARGB(255, 255, 64, 0), "Laranja Avermelhado");

  final Color cor;
  final String nome;

  const Cores(this.cor, this.nome);
}
