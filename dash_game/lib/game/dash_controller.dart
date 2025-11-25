import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class DashController {
  final VoidCallback onUpdate;

  late ui.Image dashImage;
  List<ui.Image> obstacleImages = [];

  // Explosion animation frames
  List<ui.Image> explosionFrames = [];
  int explosionFrameIndex = 0;
  bool isExploding = false;

  bool imagesLoaded = false;

  // Dash position
  double dashX = 0;
  double dashY = 0.75;
  double dashWave = 0;
  double dashSize = 0.12;

  // Obstacle position
  double obstacleX = 0;
  double obstacleY = -0.3;
  double obstacleSize = 0.12;

  // Random obstacle selection
  int currentObstacleIndex = 0;

  int score = 0;

  DashController({required this.onUpdate}) {
    loadImages();
  }

  Future<void> loadImages() async {
    dashImage = await _loadImage("assets/dash.png");

    for (String path in [
      "assets/rock.png",
      "assets/fire.png",
      "assets/meteor.png"
    ]) {
      obstacleImages.add(await _loadImage(path));
    }

    // Load explosion animation frames
    for (int i = 0; i < 8; i++) {
      explosionFrames.add(await _loadImage("assets/explosion/explosion_$i.png"));
    }

    imagesLoaded = true;
    onUpdate();
  }

  Future<ui.Image> _loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = Uint8List.view(data.buffer);
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  ui.Image get currentObstacleImage => obstacleImages[currentObstacleIndex];
  ui.Image get currentExplosionFrame => explosionFrames[explosionFrameIndex];

  // Move dash horizontally
  void moveDash(double dx) {
    if (isExploding) return; // Can't move during explosion
    dashX += dx / 300;
    dashX = dashX.clamp(-1.0, 1.0);
  }

  // Game update loop
  void update() {
    if (!imagesLoaded) return;

    if (isExploding) {
      explosionFrameIndex++;

      if (explosionFrameIndex >= explosionFrames.length) {
        isExploding = false;
        explosionFrameIndex = 0;
        resetObstacle();
        score = 0;
      }

      onUpdate();
      return;
    }

    dashWave += 0.1;
    dashY = 0.75 + sin(dashWave) * 0.02;

    obstacleY += 0.012;

    if (obstacleY > 1.3) {
      score++;
      resetObstacle();
    }

    if (isColliding()) startExplosion();

    onUpdate();
  }

  bool isColliding() {
    bool hitX = (dashX - obstacleX).abs() < dashSize * 0.7;
    bool hitY = (dashY - obstacleY).abs() < dashSize * 0.7;
    return hitX && hitY;
  }

  void startExplosion() {
    isExploding = true;
    explosionFrameIndex = 0;
  }

  void resetObstacle() {
    obstacleY = -0.3;
    obstacleX = Random().nextDouble() * 2 - 1;
    currentObstacleIndex = Random().nextInt(obstacleImages.length);
  }
}
