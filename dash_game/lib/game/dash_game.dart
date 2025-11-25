import 'package:flutter/material.dart';
import 'dart:async';

import 'dash_controller.dart';
import 'dash_painter.dart';

class DashGame extends StatefulWidget {
  @override
  _DashGameState createState() => _DashGameState();
}

class _DashGameState extends State<DashGame> {
  late DashController controller;
  Timer? gameLoop;

  @override
  void initState() {
    super.initState();
    controller = DashController(onUpdate: () => setState(() {}));

    gameLoop = Timer.periodic(const Duration(milliseconds: 16), (_) {
      controller.update();
    });
  }

  @override
  void dispose() {
    gameLoop?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (d) => controller.moveDash(d.delta.dx),
      child: Stack(
        children: [
          CustomPaint(
            painter: DashPainter(controller),
            child: Container(),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Text(
              "Score: ${controller.score}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
