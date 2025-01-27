import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LearnSignLanguage extends StatefulWidget {
  const LearnSignLanguage({super.key});

  @override
  State<LearnSignLanguage> createState() => _LearnSignLanguageState();
}

class _LearnSignLanguageState extends State<LearnSignLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'APRENDENDO LIBRAS',
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: AprendendoLibrasComp(),
    );
  }
}

class AprendendoLibrasComp extends StatefulWidget {
  const AprendendoLibrasComp({super.key});

  @override
  State<AprendendoLibrasComp> createState() => _AprendendoLibrasCompState();
}

class _AprendendoLibrasCompState extends State<AprendendoLibrasComp> {
  int index = 0;
  List<String> letras = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  late AudioPlayer player;
  late TextToSpeechComponent falador;

  @override
  void initState() {
    super.initState();
    falador = TextToSpeechComponent();
    player = AudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await TextToSpeechComponent.setAwaitOptions();
      await TextToSpeechComponent.speak("Vamos aprender os sinais de libras");
      await _speakSign();
    });
  }

  Future<void> _speakSign() async {
    await TextToSpeechComponent.speak('Essa é a letra: ${letras[index]}');
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Vamos Aprender os sinais da libras',
              style: TextStyle(
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 300,
              child: Image.asset(
                  'assets/images/alphabet_libras/${letras[index]}.png'),
            ),
            Text(
              'Esse é o sinal que representa a letra \'${letras[index]}\'!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Tente fazer esse sinal.',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        if (index == 0) {
                          Fluttertoast.showToast(
                              msg: "nao da pra fazer isso agora",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.lightBlueAccent,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else {
                          index--;
                        }
                      });
                      await _speakSign();
                    },
                    child: Text('Voltar')),
                FilledButton(
                  onPressed: () async {
                    setState(() {
                      if (index == 25) {
                        index = 0;
                      } else {
                        index++;
                      }
                    });
                    await _speakSign();
                  },
                  child: Text('Proximo sinal'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
