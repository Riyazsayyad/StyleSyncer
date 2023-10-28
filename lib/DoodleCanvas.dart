import 'package:flutter/material.dart';

import 'DoodlePainter.dart' as doodlePainter;

class DoodleCanvas extends StatefulWidget {
  const DoodleCanvas({super.key});

  @override
  _DoodleCanvasState createState() => _DoodleCanvasState();
}

class _DoodleCanvasState extends State<DoodleCanvas> {
  List<Offset> points = <Offset>[];
  bool clearCanvas = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Canvas"), backgroundColor: Colors.black),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            points.add(renderBox.globalToLocal(details.globalPosition));
          });
        },
        onPanEnd: (details) {
          clearDoodleAfterDelay();
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: doodlePainter.DoodlePainter(points),
        ),
      ),
    );
  }

  void clearDoodleAfterDelay() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        points.clear();
      });
    });
  }
}
