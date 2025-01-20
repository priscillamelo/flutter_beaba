import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/aprendendo_libras_comp.dart';

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
        title: Text('Aprendendo Libras'),
      ),
      body: AprendendoLibrasComp(),
    );
  }
}
