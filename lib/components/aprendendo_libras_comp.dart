import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/text_to_speech_component.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    TextToSpeechComponent.speak('');
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextToSpeechComponent.speak('essa é a letra ${letras[index]}');
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
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 342,
              child: Image.asset(
                  'assets/images/alphabet_libras/${letras[index]}.png'),
            ),
            Text(
              'Esse é o sinal que representa a letra \'${letras[index]}\'!',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Tenta fazer esse sinal.',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              spacing: 5,
              children: [
                OutlinedButton(
                    onPressed: () {
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
                    },
                    child: Text('Sinal anterior')),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      if (index == 25) {
                        index = 0;
                      } else {
                        index++;
                      }
                    });
                  },
                  child: Text('Vamos ver o proximo sinal.'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
