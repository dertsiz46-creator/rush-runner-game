import 'package:shared_preferences/shared_preferences.dart';

/// Score manager to handle score and high score
class ScoreManager {
  static final ScoreManager _instance = ScoreManager._internal();
  
  factory ScoreManager() {
    return _instance;
  }
  
  ScoreManager._internal();
  
  int _currentScore = 0;
  int _highScore = 0;
  int _coins = 0;
  SharedPreferences? _prefs;
  
  static const String _highScoreKey = 'high_score';
  static const String _totalCoinsKey = 'total_coins';
  
  int get currentScore => _currentScore;
  int get highScore => _highScore;
  int get coins => _coins;
  
  /// Initialize score manager and load saved data
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _highScore = _prefs?.getInt(_highScoreKey) ?? 0;
    _coins = _prefs?.getInt(_totalCoinsKey) ?? 0;
  }
  
  /// Increase current score
  void increaseScore(int points) {
    _currentScore += points;
    if (_currentScore > _highScore) {
      _highScore = _currentScore;
      _saveHighScore();
    }
  }
  
  /// Add coins
  void addCoins(int amount) {
    _coins += amount;
    _saveCoins();
  }
  
  /// Reset current score (for new game)
  void resetScore() {
    _currentScore = 0;
  }
  
  /// Save high score to persistent storage
  Future<void> _saveHighScore() async {
    await _prefs?.setInt(_highScoreKey, _highScore);
  }
  
  /// Save coins to persistent storage
  Future<void> _saveCoins() async {
    await _prefs?.setInt(_totalCoinsKey, _coins);
  }
  
  /// Get current game score (for display)
  String get scoreText => _currentScore.toString();
  
  /// Get high score text (for display)
  String get highScoreText => _highScore.toString();
  
  /// Get coins text (for display)
  String get coinsText => _coins.toString();
}
