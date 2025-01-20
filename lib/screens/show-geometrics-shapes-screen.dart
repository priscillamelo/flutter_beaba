import 'package:flutter/material.dart';
import 'package:flutter_beaba/components/show_geometrics_shapes_comp.dart';

class ShowGeometricsShapesScreen extends StatefulWidget {
  const ShowGeometricsShapesScreen({super.key});

  @override
  State<ShowGeometricsShapesScreen> createState() =>
      _ShowGeometricsShapesScreenState();
}

class _ShowGeometricsShapesScreenState
    extends State<ShowGeometricsShapesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formas Geometricas'),
      ),
      body: ShowGeometricsShapesComp(),
    );
  }
}
