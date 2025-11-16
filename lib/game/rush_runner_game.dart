import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'components/background.dart';
import 'components/ground.dart';
import 'components/player.dart';
import 'managers/game_manager.dart';
import 'managers/score_manager.dart';
import 'utils/constants.dart';

/// Main game class extending FlameGame with gesture detection
class RushRunnerGame extends FlameGame with PanDetector {
  RushRunnerGame() : super();
  
  // Game components
  late Background _background;
  late Ground _ground;
  late Player _player;
  
  // Game managers
  final GameManager _gameManager = GameManager();
  final ScoreManager _scoreManager = ScoreManager();
  
  // Current game speed
  double _currentSpeed = GameConstants.baseGameSpeed;
  
  // Score accumulator
  double _scoreAccumulator = 0;
  
  // Swipe detection
  Vector2? _panStart;
  static const double _minSwipeDistance = 50.0;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Set game dimensions
    GameConstants.gameWidth = size.x;
    GameConstants.gameHeight = size.y;
    
    // Initialize score manager
    await _scoreManager.init();
    
    // Create and add components in order (background first, player last)
    _background = Background();
    await add(_background);
    
    _ground = Ground();
    await add(_ground);
    
    _player = Player();
    await add(_player);
    
    // Start game initially
    _gameManager.startGame();
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Only update game logic if game is running
    if (_gameManager.isRunning) {
      // Update game speed (gradually increase difficulty)
      _currentSpeed += GameConstants.speedIncreaseRate * dt;
      if (_currentSpeed > GameConstants.maxGameSpeed) {
        _currentSpeed = GameConstants.maxGameSpeed;
      }
      
      _gameManager.updateSpeed(_currentSpeed);
      
      // Update score based on time
      _scoreAccumulator += dt;
      if (_scoreAccumulator >= 1.0) {
        _scoreManager.increaseScore(GameConstants.scorePerSecond);
        _scoreAccumulator = 0;
      }
    }
  }
  
  @override
  void onPanStart(DragStartInfo info) {
    super.onPanStart(info);
    _panStart = info.eventPosition.global;
  }
  
  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);
    
    if (_panStart != null && _gameManager.isRunning) {
      final panEnd = info.eventPosition.global;
      final delta = panEnd - _panStart!;
      
      // Detect horizontal swipe
      if (delta.x.abs() > _minSwipeDistance) {
        if (delta.x > 0) {
          // Swipe right
          _player.moveRight();
        } else {
          // Swipe left
          _player.moveLeft();
        }
        
        // Reset pan start to prevent multiple triggers
        _panStart = null;
      }
      
      // Detect vertical swipe (for future jump/slide mechanics)
      if (delta.y.abs() > _minSwipeDistance) {
        // Reserved for jump (up) or slide (down)
        _panStart = null;
      }
    }
  }
  
  @override
  void onPanEnd(DragEndInfo info) {
    super.onPanEnd(info);
    _panStart = null;
  }
  
  /// Pause the game
  void pauseGame() {
    _gameManager.pauseGame();
    pauseEngine();
  }
  
  /// Resume the game
  void resumeGame() {
    _gameManager.resumeGame();
    resumeEngine();
  }
  
  /// Reset game for new play
  void resetGame() {
    _currentSpeed = GameConstants.baseGameSpeed;
    _scoreAccumulator = 0;
    _scoreManager.resetScore();
    _player.reset();
    _ground.reset();
    _background.reset();
    _gameManager.reset();
    _gameManager.startGame();
  }
  
  /// Get current score
  int get currentScore => _scoreManager.currentScore;
  
  /// Get high score
  int get highScore => _scoreManager.highScore;
}
