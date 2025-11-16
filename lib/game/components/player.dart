import 'dart:ui';
import 'package:flame/components.dart';
import '../utils/constants.dart';

/// Player character component
class Player extends PositionComponent {
  Player() : super();
  
  // Current lane (0 = left, 1 = center, 2 = right)
  int _currentLane = 1;
  
  // Target position for smooth lane switching
  double _targetX = 0;
  
  // Animation progress for lane switching (0.0 to 1.0)
  double _switchProgress = 1.0;
  
  int get currentLane => _currentLane;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Set player size
    size = Vector2(GameConstants.playerWidth, GameConstants.playerHeight);
    
    // Initial position (center lane)
    _targetX = GameConstants.centerLaneX;
    position = Vector2(_targetX, GameConstants.playerStartY);
    
    // Center anchor for easier positioning
    anchor = Anchor.center;
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Smooth lane switching animation
    if (_switchProgress < 1.0) {
      _switchProgress += dt / GameConstants.laneSwitchDuration;
      if (_switchProgress > 1.0) {
        _switchProgress = 1.0;
      }
      
      // Interpolate position
      position.x = _lerp(position.x, _targetX, _switchProgress);
    }
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Simple rectangle for now (will be replaced with sprite later)
    final paint = Paint()
      ..color = GameConstants.playerColor
      ..style = PaintingStyle.fill;
    
    final rect = Rect.fromCenter(
      center: Offset(size.x / 2, size.y / 2),
      width: size.x,
      height: size.y,
    );
    
    canvas.drawRect(rect, paint);
  }
  
  /// Move player to left lane
  void moveLeft() {
    if (_currentLane > 0) {
      _currentLane--;
      _updateTargetPosition();
    }
  }
  
  /// Move player to right lane
  void moveRight() {
    if (_currentLane < GameConstants.numberOfLanes - 1) {
      _currentLane++;
      _updateTargetPosition();
    }
  }
  
  /// Update target position based on current lane
  void _updateTargetPosition() {
    _switchProgress = 0.0;
    
    switch (_currentLane) {
      case 0:
        _targetX = GameConstants.leftLaneX;
        break;
      case 1:
        _targetX = GameConstants.centerLaneX;
        break;
      case 2:
        _targetX = GameConstants.rightLaneX;
        break;
    }
  }
  
  /// Linear interpolation helper
  double _lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }
  
  /// Reset player to center lane
  void reset() {
    _currentLane = 1;
    _targetX = GameConstants.centerLaneX;
    position.x = _targetX;
    _switchProgress = 1.0;
  }
}
