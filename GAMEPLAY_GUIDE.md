# 🏃 Rush Runner - Crowd Runner Game

## 🎮 Game Overview

Rush Runner is now a **Crowd Runner / Gate Runner** style game where you control a crowd that grows or shrinks based on the gates you pass through!

### How to Play

1. **Start with 5 crowd members**
2. **Drag left or right** to switch between 3 lanes
3. **Pass through gates** to apply math operations to your crowd
4. **Avoid running out of crowd members** - Game over if you reach 0!

## 🚪 Gate Types

### 🟢 Multiplication Gates (Green)
- **x2** - Double your crowd
- **x3** - Triple your crowd

### 🔵 Addition Gates (Blue)
- **+10** - Add 10 to your crowd
- **+20** - Add 20 to your crowd

### 🔴 Subtraction Gates (Red)
- **-10** - Subtract 10 from your crowd (minimum 0)

## 🎯 Strategy Tips

1. **Early game**: Focus on multiplication gates when you have a small crowd
2. **Late game**: Addition gates are safer when you have a large crowd
3. **Avoid red gates** when your crowd count is low
4. **Plan ahead**: Gates spawn every 3 seconds, so you have time to position yourself

## 🎨 Visual Guide

```
                    [Crowd: 42]
        ╔═══════════════════════════╗
        ║                           ║
        ║                           ║
        ║     [x2]    [+10]   [-10] ║
        ║      🟢      🔵      🔴   ║
        ║                           ║
        ║       👥                  ║
        ║    (Player)               ║
        ║                           ║
        ╚═══════════════════════════╝
```

## 📱 Controls

- **Drag/Swipe Left** ← Move to left lane
- **Drag/Swipe Right** → Move to right lane
- **Minimum drag**: 50 pixels to switch lanes

## 🏆 Scoring

- Your score increases automatically as you play
- Score is based on how long you survive
- Try to maintain a high crowd count for as long as possible!

## 🎬 Game Flow

```
Start Game → 5 Crowd Members → Gates Spawn Every 3s
     ↓
Pass Through Gates → Crowd Count Changes
     ↓
Crowd = 0? → Yes → GAME OVER
     ↓ No
Continue Playing → Score Increases
```

## 🔧 Technical Details

### Built With
- **Flutter** - UI Framework
- **Flame** - Game Engine (v1.16.0)
- **Dart** - Programming Language

### Features
- ✅ Smooth 60 FPS gameplay
- ✅ 3-lane system with smooth transitions
- ✅ Real-time UI updates
- ✅ Responsive drag controls
- ✅ Color-coded gate system
- ✅ Game over and restart functionality

### File Structure
```
lib/
├── game/
│   ├── components/
│   │   ├── gate.dart          # Gate component with operations
│   │   ├── player.dart        # Player with lane switching
│   │   ├── ground.dart        # Scrolling ground
│   │   └── background.dart    # Game background
│   └── rush_runner_game.dart  # Main game logic
├── screens/
│   ├── game_screen.dart       # Game UI with overlays
│   └── main_menu_screen.dart  # Main menu
└── main.dart                  # App entry point
```

## 🚀 Running the Game

```bash
# Install dependencies
flutter pub get

# Run on your device/emulator
flutter run

# Run tests
flutter test
```

## 🧪 Testing

Unit tests are included for all gate operations:
```bash
flutter test test/gate_operations_test.dart
```

## 📖 Documentation

- **IMPLEMENTATION_COMPLETE.md** - Full implementation details
- **CROWD_RUNNER_IMPLEMENTATION.md** - Technical documentation
- **README.md** - This file (gameplay guide)

## 🎮 Gameplay Examples

### Example 1: Growth Strategy
```
Start: 5
Pass x2 gate: 5 → 10
Pass x3 gate: 10 → 30
Pass +20 gate: 30 → 50
Pass -10 gate: 50 → 40 (still safe!)
```

### Example 2: Danger Zone
```
Current: 8
Pass -10 gate: 8 → 0 → GAME OVER! ❌
```

### Example 3: Recovery
```
Current: 3 (danger!)
Pass +20 gate: 3 → 23 (safe!) ✅
Pass x3 gate: 23 → 69 (excellent!)
```

## 🎯 Goals

- **Survive as long as possible**
- **Maximize your crowd count**
- **Achieve the highest score**
- **Master lane switching timing**

## 🆕 What's New

This implementation adds:
- Complete crowd runner mechanics
- 5 different gate operations
- Real-time crowd counter UI
- Game over and restart system
- Smooth lane switching controls
- Comprehensive test coverage

## 🤝 Contributing

Feel free to:
- Add new gate operations
- Enhance visual effects
- Add sound effects
- Implement power-ups
- Create new difficulty levels

## 📝 License

MIT License - See project root for details

## 👨‍💻 Developer

Created by dertsiz46-creator

---

**Ready to play?** Run `flutter run` and start growing your crowd! 🎉
