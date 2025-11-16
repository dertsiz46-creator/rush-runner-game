import 'package:flutter/material.dart';

/// Game constants and configuration
class GameConstants {
  // Screen dimensions (will be set dynamically)
  static double gameWidth = 400;
  static double gameHeight = 800;
  
  // Lane system - 3 lanes
  static const int numberOfLanes = 3;
  static const double laneWidth = 100;
  
  // Lane positions (center of each lane)
  static double get leftLaneX => gameWidth / 2 - laneWidth;
  static double get centerLaneX => gameWidth / 2;
  static double get rightLaneX => gameWidth / 2 + laneWidth;
  
  // Player configuration
  static const double playerWidth = 50;
  static const double playerHeight = 60;
  static double get playerStartY => gameHeight * 0.7;
  
  // Game speeds
  static const double baseGameSpeed = 300.0; // pixels per second
  static const double speedIncreaseRate = 5.0; // speed increase per second
  static const double maxGameSpeed = 800.0;
  
  // Ground configuration
  static const double groundHeight = 100;
  static const double groundSpeed = 300.0;
  
  // Background configuration
  static const double backgroundSpeed = 100.0;
  
  // Animation configuration
  static const double laneSwitchDuration = 0.2; // seconds
  
  // Scoring
  static const int scorePerSecond = 10;
  static const int coinValue = 50;
  
  // Colors
  static const Color playerColor = Colors.blue;
  static const Color groundColor = Color(0xFF8B7355);
  static const Color skyColor = Color(0xFF87CEEB);
  static const Color backgroundColor = Color(0xFF2C1810);
}
