import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'components/player.dart';
import 'components/ground.dart';
import 'components/background.dart';

class RushRunnerGame extends FlameGame with PanDetector {
  late Player player;
  late Ground ground;
  late Background background;
  
  double gameSpeed = 300.0;
  int score = 0;
  bool isGameOver = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Add background
    background = Background();
    add(background);
    
    // Add ground
    ground = Ground();
    add(ground);
    
    // Add player
    player = Player();
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (!isGameOver) {
      score += (gameSpeed * dt).toInt();
      
      // Increase speed over time
      if (score % 1000 == 0) {
        gameSpeed += 10;
      }
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    // Swipe detection will be added here
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // Swipe detection will be added here
  }

  @override
  void onPanEnd(DragEndInfo info) {
    // Swipe detection will be added here
  }

  void gameOver() {
    isGameOver = true;
  }

  void restart() {
    isGameOver = false;
    score = 0;
    gameSpeed = 300.0;
  }
}
