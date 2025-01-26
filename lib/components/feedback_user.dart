import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';

class FeedbackUser {
  static final AudioPlayer audioPlayer = AudioPlayer();

  static Future<void> checkWinner(BuildContext context, bool winner) async {
    showDialogImage(context, winner);
    if (winner == true) {
      await audioPlayer.play(AssetSource('audios/feedback-winner.m4a'));
    } else {
      await audioPlayer.play(AssetSource('audios/feedback-lose2.m4a'));
      Future.delayed(Duration(seconds: 2), () {
        TextToSpeechComponent.speak('Vamos tentar novamente!');
      });
    }
  }

  static Future<void> showDialogImage(BuildContext context, bool winner) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 5), () {
            if (context.mounted) Navigator.of(context).pop();
          });
          return AlertDialog(
            title: winner
                ? Text("Parabéns, você acertou!!")
                : Text(('Humm, vamos tentar novamente!')),
            content: Image.asset(winner
                ? 'assets/images/winner.png'
                : 'assets/images/loser.png'),
          );
        });
  }
}
