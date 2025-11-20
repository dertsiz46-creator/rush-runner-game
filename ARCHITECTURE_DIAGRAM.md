# Crowd Runner Game - Architecture Diagram

## System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                       Main Application                       │
│                     (lib/main.dart)                         │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│                    MainMenuScreen                           │
│              (lib/screens/main_menu_screen.dart)            │
│  ┌────────────────────────────────────────────────────┐    │
│  │  [🏃 RUSH RUNNER]                                  │    │
│  │                                                     │    │
│  │          ┌──────────────────┐                      │    │
│  │          │   PLAY BUTTON    │                      │    │
│  │          └──────────────────┘                      │    │
│  └────────────────────────────────────────────────────┘    │
└────────────────┬────────────────────────────────────────────┘
                 │ User Taps Play
                 ▼
┌─────────────────────────────────────────────────────────────┐
│                      GameScreen                             │
│               (lib/screens/game_screen.dart)                │
│  ┌────────────────────────────────────────────────────┐    │
│  │           [Crowd: 42] ← ValueNotifier              │    │
│  │  ┌──────────────────────────────────────────┐     │    │
│  │  │          FlameGame Widget                 │     │    │
│  │  │  ┌────────────────────────────────────┐  │     │    │
│  │  │  │   RushRunnerGame (Flame Engine)    │  │     │    │
│  │  │  │  - Background Component             │  │     │    │
│  │  │  │  - Ground Component                 │  │     │    │
│  │  │  │  - Player Component (3 lanes)       │  │     │    │
│  │  │  │  - Gate Components (spawned)        │  │     │    │
│  │  │  └────────────────────────────────────┘  │     │    │
│  │  └──────────────────────────────────────────┘     │    │
│  │                                                     │    │
│  │  Game Over Overlay (conditional)                   │    │
│  │  ┌──────────────────────────────────────────┐     │    │
│  │  │  GAME OVER                                │     │    │
│  │  │  Final Score: 1234                        │     │    │
│  │  │  [RESTART]  [Back to Menu]               │     │    │
│  │  └──────────────────────────────────────────┘     │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

## Component Hierarchy

```
RushRunnerGame (FlameGame)
├── Background (Component)
│   └── Sky gradient rendering
├── Ground (Component)
│   └── Scrolling ground with grid lines
├── Player (PositionComponent)
│   ├── Lane system (0, 1, 2)
│   ├── Smooth lane switching
│   └── Visual rendering (blue rect with eyes)
└── Gates[] (List<Gate>)
    ├── Gate 1 (PositionComponent)
    │   ├── GateOperation (enum)
    │   ├── Lane index
    │   ├── Visual rendering
    │   └── Collision detection
    ├── Gate 2
    └── Gate N...
```

## Data Flow

```
User Input (Drag)
      │
      ▼
PanDetector (RushRunnerGame)
      │
      ├─→ onPanStart: Save start position
      ├─→ onPanUpdate: Calculate delta
      │        │
      │        ├─→ deltaX > 50? Move right
      │        └─→ deltaX < -50? Move left
      │
      └─→ onPanEnd: Clear start position
              │
              ▼
Player.moveToLane(newLane)
              │
              ▼
Player.update(dt)
      │
      └─→ Smooth animation to target X
```

## Game Loop

```
┌─────────────────────────────────────────┐
│     RushRunnerGame.update(dt)          │
└───┬─────────────────────────────────────┘
    │
    ├─→ Update score
    │   └─→ score += gameSpeed * dt
    │
    ├─→ Gate spawning timer
    │   └─→ timeSinceLastGate += dt
    │       └─→ If >= 3.0s: spawnGate()
    │           ├─→ Random lane (0-2)
    │           ├─→ Random operation
    │           └─→ Add gate at top
    │
    ├─→ Check gate collisions
    │   └─→ For each gate:
    │       ├─→ Move gate down (gameSpeed)
    │       ├─→ Check if off screen → remove
    │       └─→ Check player collision
    │           ├─→ Same lane?
    │           ├─→ Y position overlap?
    │           └─→ Apply operation
    │               └─→ crowdCount = gate.applyOperation(crowdCount)
    │                   └─→ ValueNotifier updates UI
    │
    └─→ Check game over
        └─→ crowdCount <= 0?
            └─→ gameOver() → ValueNotifier triggers overlay
```

## Gate Operations

```
GateOperation Enum
├── multiply2 → crowdCount * 2
├── multiply3 → crowdCount * 3
├── add10     → crowdCount + 10
├── add20     → crowdCount + 20
└── subtract10 → max(0, crowdCount - 10)

Visual Mapping:
├── Multiply → Green gates
├── Add      → Blue gates
└── Subtract → Red gates
```

## State Management

```
RushRunnerGame State:
├── crowdCount (private)
│   └── crowdCountNotifier (ValueNotifier<int>)
│       └── Updates UI immediately
├── isGameOver (private)
│   └── gameOverNotifier (ValueNotifier<bool>)
│       └── Triggers overlay
├── gameSpeed (increases over time)
├── score (based on time survived)
└── Gates[] (dynamic list)
```

## UI React Pattern

```
GameScreen (StatefulWidget)
└── Stack
    ├── GameWidget(game)
    │
    ├── Crowd Display
    │   └── ValueListenableBuilder<int>
    │       └── Listens to: game.crowdCountNotifier
    │           └── Rebuilds only this widget
    │
    └── Game Over Overlay
        └── ValueListenableBuilder<bool>
            └── Listens to: game.gameOverNotifier
                └── Shows/hides overlay
```

## Lane System

```
Screen Width: W

Lane 0 (Left):   X = W * 0.25
Lane 1 (Center): X = W * 0.50
Lane 2 (Right):  X = W * 0.75

Player Movement:
├── Current position
├── Target position (based on lane)
└── Lerp at 500 px/s
```

## Collision Detection

```
Gate Collision Check:
├── Lane Match: gate.laneIndex == player.currentLane
└── Y Overlap: gate.y >= player.y - 50
              AND gate.y <= player.y + 50
    └── If both true:
        ├── Apply gate operation
        └── Mark gate as passed
```

## File Structure

```
lib/
├── main.dart
├── game/
│   ├── rush_runner_game.dart ◄─── Main game logic
│   ├── components/
│   │   ├── gate.dart ◄─────────── NEW: Gate component
│   │   ├── player.dart ◄────────── MODIFIED: Lane switching
│   │   ├── ground.dart
│   │   └── background.dart
│   ├── managers/
│   │   ├── game_manager.dart
│   │   └── score_manager.dart
│   └── utils/
│       └── constants.dart
├── screens/
│   ├── game_screen.dart ◄────────── MODIFIED: UI overlays
│   └── main_menu_screen.dart
└── widgets/
    └── game_button.dart

test/
└── gate_operations_test.dart ◄──── NEW: Unit tests
```

## Performance Considerations

```
Optimizations:
├── ValueNotifier: Only rebuilds affected widgets
├── Gate cleanup: Removed when off-screen
├── Collision checks: Only visible gates
├── Flame engine: 60 FPS game loop
└── Component-based: Efficient rendering
```

## Testing Strategy

```
Unit Tests (test/gate_operations_test.dart):
├── All 5 operations tested
├── Edge cases (zero, negative)
├── Visual properties (colors, text)
└── Operation correctness

Integration Tests (Manual):
├── Gate spawning timing
├── Collision detection accuracy
├── UI responsiveness
├── Game over triggering
└── Restart functionality
```

## Future Extension Points

```
Easy to Add:
├── New gate operations (extend GateOperation enum)
├── Different difficulties (adjust spawn rate)
├── Power-ups (new component type)
├── Obstacles (similar to gates)
├── Sound effects (at gate collision points)
├── Particle effects (in gate render method)
└── Multiplayer (separate game instances)
```

---

This architecture provides:
- ✅ Clear separation of concerns
- ✅ Easy to understand flow
- ✅ Simple to extend
- ✅ Performant at 60 FPS
- ✅ Testable components
