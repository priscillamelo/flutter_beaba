import 'package:flutter/material.dart';

class ShowGeometricsShapesComp extends StatefulWidget {
  const ShowGeometricsShapesComp({super.key});

  @override
  State<ShowGeometricsShapesComp> createState() =>
      _ShowGeometricsShapesCompState();
}

class _ShowGeometricsShapesCompState extends State<ShowGeometricsShapesComp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/formas_aprender/triangulo_aprender.png'),
            Text(
              'Esse é o triangulo!!',
              style: TextStyle(fontSize: 26),
            ),
            Row(
              children: [
                SizedBox(
                  child: OutlinedButton(
                      onPressed: () {}, child: Text('Forma anterior')),
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text('Próxima forma'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
