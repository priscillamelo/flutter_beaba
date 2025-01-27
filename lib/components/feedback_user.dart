import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class FeedbackUser {
  static final AudioPlayer audioPlayer = AudioPlayer();

  static Future<void> feedbackDrawing({
    required BuildContext context,
    required bool winner,
  }) async {
    if (winner == true) {
      await audioPlayer.play(AssetSource('audios/feedback-winner.m4a'));
      Future.delayed(Duration(seconds: 1), () {
        TextToSpeechComponent.speak("Parabéns, você acertou!");
      });
    } else {
      await audioPlayer.play(AssetSource('audios/feedback-lose2.m4a'));
      Future.delayed(Duration(seconds: 1), () {
        TextToSpeechComponent.speak('Vamos tentar novamente!');
      });
    }
  }

  static Future<void> showDialogFeedback({
    required BuildContext context,
    required Text title,
    required dynamic content,
  }) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 4), () {
            if (context.mounted) Navigator.of(context).pop();
          });
          return AlertDialog(
            title: title,
            content: content,
          );
        });
  }

  static Future<void> feedbackRecognize(bool winner) async {
    if (winner) {
      await audioPlayer.play(AssetSource('audios/correct-answer.m4a'));
    } else {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(preset: VibrationPreset.gentleReminder);
      }
    }
  }

  static Animation<double> createAnimationShakeScreen(
      AnimationController controller) {
    final Animation<double> animation = TweenSequence<double>([
      TweenSequenceItem(
        tween:
            Tween(begin: 0.0, end: 30.0).chain(CurveTween(curve: Curves.ease)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 30.0, end: -20.0)
            .chain(CurveTween(curve: Curves.ease)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -20.0, end: 10.0)
            .chain(CurveTween(curve: Curves.ease)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween:
            Tween(begin: 10.0, end: -6.0).chain(CurveTween(curve: Curves.ease)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween:
            Tween(begin: -6.0, end: 0.0).chain(CurveTween(curve: Curves.ease)),
        weight: 1,
      ),
    ]).animate(controller);

    return animation;
  }
}
