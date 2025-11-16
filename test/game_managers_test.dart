import 'package:flutter_test/flutter_test.dart';
import 'package:rush_runner/game/managers/game_manager.dart';
import 'package:rush_runner/game/managers/score_manager.dart';

void main() {
  group('Game Managers Tests', () {
    test('GameManager starts correctly', () {
      final gameManager = GameManager();
      
      // Initial state should be initial
      expect(gameManager.state, GameState.initial);
      
      // Start game
      gameManager.startGame();
      expect(gameManager.state, GameState.running);
      expect(gameManager.isRunning, true);
      
      // Pause game
      gameManager.pauseGame();
      expect(gameManager.state, GameState.paused);
      expect(gameManager.isPaused, true);
      
      // Resume game
      gameManager.resumeGame();
      expect(gameManager.state, GameState.running);
      
      // Game over
      gameManager.gameOver();
      expect(gameManager.state, GameState.gameOver);
      expect(gameManager.isGameOver, true);
      
      // Reset
      gameManager.reset();
      expect(gameManager.state, GameState.initial);
    });
    
    test('ScoreManager handles scores correctly', () {
      final scoreManager = ScoreManager();
      
      // Initial score should be 0
      expect(scoreManager.currentScore, 0);
      
      // Increase score
      scoreManager.increaseScore(100);
      expect(scoreManager.currentScore, 100);
      
      // Increase more
      scoreManager.increaseScore(50);
      expect(scoreManager.currentScore, 150);
      
      // Reset score
      scoreManager.resetScore();
      expect(scoreManager.currentScore, 0);
    });
  });
}
