import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent {
  static const double groundHeight = 100;
  double scrollSpeed = 300.0;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    size = Vector2(parent!.size.x, groundHeight);
    position = Vector2(0, parent!.size.y - groundHeight);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Ground scrolling effect will be added here
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final paint = Paint()
      ..color = const Color(0xFF228B22)
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(size.toRect(), paint);
    
    // Draw lines for effect
    final linePaint = Paint()
      ..color = const Color(0xFF1a6b1a)
      ..strokeWidth = 2;
    
    for (int i = 0; i < 5; i++) {
      canvas.drawLine(
        Offset(0, i * 20),
        Offset(size.x, i * 20),
        linePaint,
      );
    }
  }
}
