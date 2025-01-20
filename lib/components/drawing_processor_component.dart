import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class DrawingProcessorComponent {
  // Função para capturar a imagem da letra tracejada
  static Future<Uint8List> captureImageLetterTrace(
      GlobalKey globalKeyTrace) async {
    await Future.delayed(Duration.zero);
    RenderRepaintBoundary? boundary = globalKeyTrace.currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary!.debugNeedsPaint) {
      // Aguarda um próximo frame para garantir que foi renderizado
      await Future.delayed(const Duration(milliseconds: 16));
    }

    ui.Image image = await boundary.toImage();

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    return pngBytes!;
  }

  // Função para capturar a imagem do desenho do usuário
  static Future<Uint8List> captureImageLetterUser(
      GlobalKey globalKeyUser) async {
    RenderRepaintBoundary? boundary = globalKeyUser.currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage();

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    return pngBytes!;
  }

  // Função de comparação entre a imagem da letra tracejada e o desenho do usuário
  static bool compareImages(Uint8List imageTrace, Uint8List imageUser) {
    img.Image? imgTrace = img.decodeImage(imageTrace);
    img.Image? imgUser = img.decodeImage(imageUser);

    if (imgTrace == null || imgUser == null) {
      throw Exception('Erro: Falha ao decodificar uma ou ambas as imagens.');
    }

    if (imgTrace.width != imgUser.width || imgTrace.height != imgUser.height) {
      throw Exception('Erro: As dimensões das imagens não coincidem.');
    }

    // Calcula os pixels cobertos
    int totalPixelsLetterDashed = 0;
    //int totalPixelsLetterUser = 0;
    int coveredPixels = 0;

    for (int y = 0; y < imgUser.height; y++) {
      for (int x = 0; x < imgUser.width; x++) {
        img.Pixel pixelTrace = imgTrace.getPixelSafe(x, y);
        img.Pixel pixelUser = imgUser.getPixelSafe(x, y);

        if (pixelTrace.r > 0) {
          totalPixelsLetterDashed++;

          if (pixelUser.a > 0) {
            coveredPixels++;
          }
        }
      }
    }
    // Calcula a porcentagem de cobertura
    final coveragePercentage = (coveredPixels / totalPixelsLetterDashed) * 100;
    return coveragePercentage > 35;
  }
}
