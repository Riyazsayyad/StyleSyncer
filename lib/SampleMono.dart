import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoodleCanvas(),
    );
  }
}

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
      appBar: AppBar(
        title: Text("Doodle Canvas"),
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.person)],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          points.add(renderBox.globalToLocal(details.globalPosition));
        },
        onPanEnd: (details) {
          clearDoodleAfterDelay();
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: DoodlePainter(points),
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

class DoodlePainter extends CustomPainter {
  final List<Offset> points;
  DoodlePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
