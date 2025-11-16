import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Background extends PositionComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    size = parent!.size;
    position = Vector2.zero();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    final gradient = ui.Gradient.linear(
      Offset(size.x / 2, 0),
      Offset(size.x / 2, size.y),
      [
        const Color(0xFF87CEEB),
        const Color(0xFFE0F6FF),
      ],
    );
    
    final paint = Paint()..shader = gradient;
    canvas.drawRect(rect, paint);
  }
}
