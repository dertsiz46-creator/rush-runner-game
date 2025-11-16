/// Game state enum
enum GameState {
  initial,
  running,
  paused,
  gameOver,
}

/// Singleton game manager to handle game state
class GameManager {
  static final GameManager _instance = GameManager._internal();
  
  factory GameManager() {
    return _instance;
  }
  
  GameManager._internal();
  
  GameState _state = GameState.initial;
  double _currentSpeed = 0;
  
  GameState get state => _state;
  double get currentSpeed => _currentSpeed;
  
  /// Start the game
  void startGame() {
    _state = GameState.running;
    _currentSpeed = 0;
  }
  
  /// Pause the game
  void pauseGame() {
    if (_state == GameState.running) {
      _state = GameState.paused;
    }
  }
  
  /// Resume the game
  void resumeGame() {
    if (_state == GameState.paused) {
      _state = GameState.running;
    }
  }
  
  /// End the game
  void gameOver() {
    _state = GameState.gameOver;
  }
  
  /// Reset the game
  void reset() {
    _state = GameState.initial;
    _currentSpeed = 0;
  }
  
  /// Update current speed
  void updateSpeed(double speed) {
    _currentSpeed = speed;
  }
  
  /// Check if game is running
  bool get isRunning => _state == GameState.running;
  
  /// Check if game is paused
  bool get isPaused => _state == GameState.paused;
  
  /// Check if game is over
  bool get isGameOver => _state == GameState.gameOver;
}
