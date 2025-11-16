import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../game/rush_runner_game.dart';
import '../widgets/game_button.dart';

/// Game screen that displays the Flame game
class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late RushRunnerGame _game;
  
  @override
  void initState() {
    super.initState();
    _game = RushRunnerGame();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Game widget
          GameWidget(
            game: _game,
            overlayBuilderMap: {
              'PauseMenu': _buildPauseMenu,
              'GameOver': _buildGameOverMenu,
            },
          ),
          
          // Score display (top of screen)
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Current score
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ValueListenableBuilder<int>(
                    valueListenable: _ScoreNotifier(_game),
                    builder: (context, score, child) {
                      return Text(
                        'Score: $score',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
                
                // Pause button
                IconButton(
                  icon: const Icon(Icons.pause, color: Colors.white, size: 32),
                  onPressed: () {
                    _game.pauseGame();
                    _game.overlays.add('PauseMenu');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// Build pause menu overlay
  Widget _buildPauseMenu(BuildContext context, RushRunnerGame game) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'PAUSED',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 30),
            
            GameButton(
              text: 'RESUME',
              onPressed: () {
                game.overlays.remove('PauseMenu');
                game.resumeGame();
              },
            ),
            
            const SizedBox(height: 15),
            
            GameButton(
              text: 'MENU',
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
  
  /// Build game over menu overlay
  Widget _buildGameOverMenu(BuildContext context, RushRunnerGame game) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'GAME OVER',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 20),
            
            Text(
              'Score: ${game.currentScore}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            
            Text(
              'Best: ${game.highScore}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
            
            const SizedBox(height: 30),
            
            GameButton(
              text: 'PLAY AGAIN',
              onPressed: () {
                game.overlays.remove('GameOver');
                game.resetGame();
              },
            ),
            
            const SizedBox(height: 15),
            
            GameButton(
              text: 'MENU',
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// ValueNotifier for score updates
class _ScoreNotifier extends ValueNotifier<int> {
  final RushRunnerGame game;
  
  _ScoreNotifier(this.game) : super(0) {
    _startListening();
  }
  
  void _startListening() {
    // Update score every frame
    Future.delayed(const Duration(milliseconds: 100), () {
      if (hasListeners) {
        value = game.currentScore;
        _startListening();
      }
    });
  }
}
