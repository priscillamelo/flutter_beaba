import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechComponent {
  static final FlutterTts _tts = FlutterTts();
  static final String language = 'pt-BR';

  static void _initializeTts() async {
    await _tts.setLanguage(language);
    await _tts.setVoice({"name": "pt-br-x-pte-local", "locale": "pt-BR"});
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.2); // Aumenta o tom, soando mais infantil
    await _tts.setSpeechRate(0.5);
  }

  static Future<void> speak(String text) async {
    _initializeTts();
    try {
      await _tts.speak(text);
    } catch (e) {
      throw Exception("Erro ao falar: $e");
    }
  }

  static Future<void> setAwaitOptions() async {
    await _tts.awaitSpeakCompletion(true);
  }

  static void pause() async {
    try {
      await _tts.pause();
    } catch (e) {
      throw Exception("Erro ao pausar: $e");
    }
  }

  static void stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      throw Exception("Erro ao parar: $e");
    }
  }
}
