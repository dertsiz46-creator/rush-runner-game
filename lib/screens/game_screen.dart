import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/rush_runner_game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late RushRunnerGame game;

  @override
  void initState() {
    super.initState();
    game = RushRunnerGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: game),
    );
  }
}
