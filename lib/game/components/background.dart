import 'dart:ui';
import 'package:flame/components.dart';
import '../utils/constants.dart';

/// Background component with parallax scrolling effect
class Background extends PositionComponent {
  Background() : super();
  
  double _scrollOffset = 0;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Set background size to cover entire screen
    size = Vector2(GameConstants.gameWidth, GameConstants.gameHeight);
    
    // Position at origin
    position = Vector2.zero();
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Update scroll offset for parallax effect (slower than ground)
    _scrollOffset += GameConstants.backgroundSpeed * dt;
    
    // Reset offset for tiling
    if (_scrollOffset >= 200) {
      _scrollOffset = 0;
    }
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Draw sky gradient
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          GameConstants.skyColor,
          GameConstants.skyColor.withOpacity(0.7),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.x, size.y));
    
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
    
    // Draw simple cloud-like shapes for visual effect
    final cloudPaint = Paint()
      ..color = const Color(0xFFFFFFFF).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    // Draw multiple clouds with scrolling effect
    for (var i = 0; i < 3; i++) {
      final y = (i * 150 - _scrollOffset) % size.y;
      
      // Draw simple cloud shapes
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(size.x * 0.2 + i * 50, y + 100),
          width: 80,
          height: 40,
        ),
        cloudPaint,
      );
      
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(size.x * 0.7 - i * 30, y + 200),
          width: 100,
          height: 50,
        ),
        cloudPaint,
      );
    }
  }
  
  /// Reset background
  void reset() {
    _scrollOffset = 0;
  }
}
