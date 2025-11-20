import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum GateOperation {
  multiply2,
  multiply3,
  add10,
  add20,
  subtract10,
}

class Gate extends PositionComponent {
  static const double gateWidth = 80;
  static const double gateHeight = 100;
  
  final GateOperation operation;
  final int laneIndex; // 0=left, 1=center, 2=right
  bool hasBeenPassed = false;
  
  Gate({
    required this.operation,
    required this.laneIndex,
    required Vector2 position,
  }) : super(
    position: position,
    size: Vector2(gateWidth, gateHeight),
  );

  String get operationText {
    switch (operation) {
      case GateOperation.multiply2:
        return 'x2';
      case GateOperation.multiply3:
        return 'x3';
      case GateOperation.add10:
        return '+10';
      case GateOperation.add20:
        return '+20';
      case GateOperation.subtract10:
        return '-10';
    }
  }

  Color get gateColor {
    switch (operation) {
      case GateOperation.multiply2:
      case GateOperation.multiply3:
        return Colors.green;
      case GateOperation.add10:
      case GateOperation.add20:
        return Colors.blue;
      case GateOperation.subtract10:
        return Colors.red;
    }
  }

  int applyOperation(int currentCount) {
    switch (operation) {
      case GateOperation.multiply2:
        return currentCount * 2;
      case GateOperation.multiply3:
        return currentCount * 3;
      case GateOperation.add10:
        return currentCount + 10;
      case GateOperation.add20:
        return currentCount + 20;
      case GateOperation.subtract10:
        return max(0, currentCount - 10);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Draw gate frame (two vertical posts)
    final framePaint = Paint()
      ..color = gateColor
      ..style = PaintingStyle.fill;
    
    // Left post
    canvas.drawRect(
      Rect.fromLTWH(0, 0, 15, gateHeight),
      framePaint,
    );
    
    // Right post
    canvas.drawRect(
      Rect.fromLTWH(gateWidth - 15, 0, 15, gateHeight),
      framePaint,
    );
    
    // Top bar
    canvas.drawRect(
      Rect.fromLTWH(0, 0, gateWidth, 20),
      framePaint,
    );
    
    // Draw operation text
    final textPainter = TextPainter(
      text: TextSpan(
        text: operationText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (gateWidth - textPainter.width) / 2,
        (gateHeight - textPainter.height) / 2,
      ),
    );
  }
}
