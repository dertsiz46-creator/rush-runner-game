import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent {
  static const double playerWidth = 50;
  static const double playerHeight = 80;
  
  int currentLane = 1; // 0=left, 1=center, 2=right
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    size = Vector2(playerWidth, playerHeight);
    position = Vector2(
      (parent!.size.x - playerWidth) / 2,
      parent!.size.y - 200,
    );
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
