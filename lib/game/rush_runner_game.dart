import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'components/player.dart';
import 'components/ground.dart';
import 'components/background.dart';
import 'components/gate.dart';

class RushRunnerGame extends FlameGame with PanDetector {
  late Player player;
  late Ground ground;
  late Background background;
  
  double gameSpeed = 300.0;
  int score = 0;
  bool isGameOver = false;
  
  // Crowd system
  int _crowdCount = 5;
  final ValueNotifier<int> crowdCountNotifier = ValueNotifier<int>(5);
  final ValueNotifier<bool> gameOverNotifier = ValueNotifier<bool>(false);
  
  int get crowdCount => _crowdCount;
  set crowdCount(int value) {
    _crowdCount = value;
    crowdCountNotifier.value = value;
  }
  
  // Gate spawning
  double timeSinceLastGate = 0;
  final double gateSpawnInterval = 3.0; // seconds
  final Random random = Random();
  
  // Drag control
  double? dragStartX;

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
      
      // Spawn gates
      timeSinceLastGate += dt;
      if (timeSinceLastGate >= gateSpawnInterval) {
        spawnGate();
        timeSinceLastGate = 0;
      }
      
      // Check gate collisions
      checkGateCollisions();
      
      // Check game over
      if (crowdCount <= 0) {
        gameOver();
      }
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    dragStartX = info.eventPosition.global.x;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (dragStartX != null && !isGameOver) {
      double deltaX = info.eventPosition.global.x - dragStartX!;
      
      // Detect swipe left or right
      if (deltaX.abs() > 50) { // Threshold for lane switch
        if (deltaX > 0 && player.currentLane < 2) {
          player.moveToLane(player.currentLane + 1);
          dragStartX = info.eventPosition.global.x;
        } else if (deltaX < 0 && player.currentLane > 0) {
          player.moveToLane(player.currentLane - 1);
          dragStartX = info.eventPosition.global.x;
        }
      }
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
    dragStartX = null;
  }

  void gameOver() {
    isGameOver = true;
    gameOverNotifier.value = true;
  }

  void restart() {
    isGameOver = false;
    gameOverNotifier.value = false;
    score = 0;
    gameSpeed = 300.0;
    crowdCount = 5;
    timeSinceLastGate = 0;
    
    // Remove all gates
    children.whereType<Gate>().toList().forEach((gate) {
      gate.removeFromParent();
    });
  }
  
  void spawnGate() {
    // Randomly choose a lane
    int lane = random.nextInt(3);
    
    // Randomly choose an operation
    GateOperation operation = GateOperation.values[random.nextInt(GateOperation.values.length)];
    
    // Calculate lane position
    double laneX;
    switch (lane) {
      case 0:
        laneX = size.x * 0.25 - Gate.gateWidth / 2;
        break;
      case 1:
        laneX = size.x * 0.5 - Gate.gateWidth / 2;
        break;
      case 2:
        laneX = size.x * 0.75 - Gate.gateWidth / 2;
        break;
      default:
        laneX = size.x * 0.5 - Gate.gateWidth / 2;
    }
    
    final gate = Gate(
      operation: operation,
      laneIndex: lane,
      position: Vector2(laneX, -Gate.gateHeight),
    );
    
    add(gate);
  }
  
  void checkGateCollisions() {
    final gates = children.whereType<Gate>().toList();
    
    for (final gate in gates) {
      // Move gate down
      gate.position.y += gameSpeed * (1 / 60); // Approximate dt
      
      // Remove if off screen
      if (gate.position.y > size.y) {
        gate.removeFromParent();
        continue;
      }
      
      // Check collision with player
      if (!gate.hasBeenPassed && 
          gate.laneIndex == player.currentLane &&
          gate.position.y >= player.position.y - 50 &&
          gate.position.y <= player.position.y + 50) {
        
        // Apply gate operation
        crowdCount = gate.applyOperation(crowdCount);
        gate.hasBeenPassed = true;
      }
    }
  }
}
