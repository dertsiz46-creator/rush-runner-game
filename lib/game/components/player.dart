import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent {
  static const double playerWidth = 50;
  static const double playerHeight = 80;
  
  int currentLane = 1; // 0=left, 1=center, 2=right
  double targetX = 0;
  final double laneSpeed = 500.0; // Pixels per second for lane switching
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    size = Vector2(playerWidth, playerHeight);
    position = Vector2(
      (parent!.size.x - playerWidth) / 2,
      parent!.size.y - 200,
    );
    targetX = position.x;
  }

  void moveToLane(int lane) {
    if (lane < 0 || lane > 2) return;
    
    currentLane = lane;
    
    // Calculate target position based on lane
    switch (lane) {
      case 0:
        targetX = parent!.size.x * 0.25 - playerWidth / 2;
        break;
      case 1:
        targetX = parent!.size.x * 0.5 - playerWidth / 2;
        break;
      case 2:
        targetX = parent!.size.x * 0.75 - playerWidth / 2;
        break;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Smoothly move to target X position
    if ((position.x - targetX).abs() > 1) {
      double direction = targetX > position.x ? 1 : -1;
      position.x += direction * laneSpeed * dt;
      
      // Clamp to target
      if (direction > 0 && position.x > targetX) {
        position.x = targetX;
      } else if (direction < 0 && position.x < targetX) {
        position.x = targetX;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(size.toRect(), paint);
    
    // Draw simple face
    final eyePaint = Paint()..color = Colors.white;
    canvas.drawCircle(const Offset(15, 20), 5, eyePaint);
    canvas.drawCircle(const Offset(35, 20), 5, eyePaint);
  }
}
