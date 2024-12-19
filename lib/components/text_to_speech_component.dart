/* import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechComponent {
  final FlutterTts _tts = FlutterTts();
  final String language = 'pt-BR';

  TextToSpeechComponent() {
    _initializeTts();
  }

  void _initializeTts() async {
    await _tts.setLanguage(language);
    await _tts.setVoice({"name": "pt-br-x-pte-local", "locale": "pt-BR"});
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.5); // Aumenta o tom, soando mais infantil
    await _tts.setSpeechRate(0.5);
  }

  Future<void> speak(String text) async {
    try {
      await _tts.speak(text);
    } catch (e) {
      print('Erro ao falar: $e');
    }
  }

  void stop() async {
    await _tts.stop();
  }
}
 */
