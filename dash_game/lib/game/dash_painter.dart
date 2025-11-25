import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'dash_controller.dart';

class DashPainter extends CustomPainter {
  final DashController controller;

  DashPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    if (!controller.imagesLoaded) return;

    final double w = size.width;
    final double h = size.height;

    // Dash position & size
    final dashPos = Offset(
      (controller.dashX + 1) / 2 * w,
      controller.dashY * h,
    );

    final dashRect = Rect.fromCenter(
      center: dashPos,
      width: w * controller.dashSize,
      height: w * controller.dashSize,
    );

    // Explosion frame if active
    if (controller.isExploding) {
      final ui.Image explosion = controller.currentExplosionFrame;

      canvas.drawImageRect(
        explosion,
        Rect.fromLTWH(
          0,
          0,
          explosion.width.toDouble(),
          explosion.height.toDouble(),
        ),
        dashRect.inflate(40),
        Paint(),
      );
      return;
    }

    // Draw Dash
    canvas.drawImageRect(
      controller.dashImage,
      Rect.fromLTWH(
        0,
        0,
        controller.dashImage.width.toDouble(),
        controller.dashImage.height.toDouble(),
      ),
      dashRect,
      Paint(),
    );

    // Obstacle position
    final obsPos = Offset(
      (controller.obstacleX + 1) / 2 * w,
      controller.obstacleY * h,
    );

    final obsRect = Rect.fromCenter(
      center: obsPos,
      width: w * controller.obstacleSize,
      height: w * controller.obstacleSize,
    );

    // Draw Obstacle
    final obstacle = controller.currentObstacleImage;

    canvas.drawImageRect(
      obstacle,
      Rect.fromLTWH(
        0,
        0,
        obstacle.width.toDouble(),
        obstacle.height.toDouble(),
      ),
      obsRect,
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
