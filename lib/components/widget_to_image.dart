import 'package:flutter/material.dart';

class WidgetToImage extends StatefulWidget {
  final Function(GlobalKey globalKey) onImageBuilder;

  const WidgetToImage({super.key, required this.onImageBuilder});

  @override
  State<WidgetToImage> createState() => _WidgetToImageState();
}

class _WidgetToImageState extends State<WidgetToImage> {
  final GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: widget.onImageBuilder(globalKey),
    );
  }
}
