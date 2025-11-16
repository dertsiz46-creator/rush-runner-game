import 'dart:ui';
import 'package:flame/components.dart';
import '../utils/constants.dart';

/// Ground component with infinite scrolling effect
class Ground extends PositionComponent {
  Ground() : super();
  
  double _scrollOffset = 0;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Set ground size
    size = Vector2(
      GameConstants.gameWidth,
      GameConstants.groundHeight,
    );
    
    // Position at bottom of screen
    position = Vector2(0, GameConstants.gameHeight - GameConstants.groundHeight);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Update scroll offset for infinite scrolling effect
    _scrollOffset += GameConstants.groundSpeed * dt;
    
    // Reset offset when it exceeds ground height (for tiling effect)
    if (_scrollOffset >= GameConstants.groundHeight) {
      _scrollOffset = 0;
    }
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Draw ground with scrolling pattern
    final paint = Paint()
      ..color = GameConstants.groundColor
      ..style = PaintingStyle.fill;
    
    // Main ground rectangle
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(rect, paint);
    
    // Draw grid lines for visual effect
    final linePaint = Paint()
      ..color = GameConstants.backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    // Horizontal lines
    for (var i = 0; i < 5; i++) {
      final y = (i * 20 - _scrollOffset) % size.y;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.x, y),
        linePaint,
      );
    }
    
    // Vertical lane lines
    final laneLinePaint = Paint()
      ..color = GameConstants.backgroundColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    // Draw lines between lanes
    final leftLineX = GameConstants.leftLaneX - GameConstants.laneWidth / 2;
    final rightLineX = GameConstants.rightLaneX + GameConstants.laneWidth / 2;
    
    canvas.drawLine(
      Offset(leftLineX, 0),
      Offset(leftLineX, size.y),
      laneLinePaint,
    );
    
    canvas.drawLine(
      Offset(rightLineX, 0),
      Offset(rightLineX, size.y),
      laneLinePaint,
    );
  }
  
  /// Reset ground
  void reset() {
    _scrollOffset = 0;
  }
}
