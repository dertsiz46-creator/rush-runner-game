import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:rush_runner/game/components/gate.dart';

void main() {
  group('Gate Operations Tests', () {
    test('Multiply by 2 operation works correctly', () {
      final gate = Gate(
        operation: GateOperation.multiply2,
        laneIndex: 0,
        position: Vector2.zero(),
      );
      
      expect(gate.applyOperation(5), 10);
      expect(gate.applyOperation(10), 20);
      expect(gate.applyOperation(1), 2);
    });
    
    test('Multiply by 3 operation works correctly', () {
      final gate = Gate(
        operation: GateOperation.multiply3,
        laneIndex: 0,
        position: Vector2.zero(),
      );
      
      expect(gate.applyOperation(5), 15);
      expect(gate.applyOperation(10), 30);
      expect(gate.applyOperation(1), 3);
    });
    
    test('Add 10 operation works correctly', () {
      final gate = Gate(
        operation: GateOperation.add10,
        laneIndex: 0,
        position: Vector2.zero(),
      );
      
      expect(gate.applyOperation(5), 15);
      expect(gate.applyOperation(0), 10);
      expect(gate.applyOperation(100), 110);
    });
    
    test('Add 20 operation works correctly', () {
      final gate = Gate(
        operation: GateOperation.add20,
        laneIndex: 0,
        position: Vector2.zero(),
      );
      
      expect(gate.applyOperation(5), 25);
      expect(gate.applyOperation(0), 20);
      expect(gate.applyOperation(100), 120);
    });
    
    test('Subtract 10 operation works correctly and prevents negative', () {
      final gate = Gate(
        operation: GateOperation.subtract10,
        laneIndex: 0,
        position: Vector2.zero(),
      );
      
      expect(gate.applyOperation(15), 5);
      expect(gate.applyOperation(10), 0);
      expect(gate.applyOperation(5), 0); // Should not go negative
      expect(gate.applyOperation(0), 0);
    });
    
    test('Gate has correct operation text', () {
      expect(Gate(operation: GateOperation.multiply2, laneIndex: 0, position: Vector2.zero()).operationText, 'x2');
      expect(Gate(operation: GateOperation.multiply3, laneIndex: 0, position: Vector2.zero()).operationText, 'x3');
      expect(Gate(operation: GateOperation.add10, laneIndex: 0, position: Vector2.zero()).operationText, '+10');
      expect(Gate(operation: GateOperation.add20, laneIndex: 0, position: Vector2.zero()).operationText, '+20');
      expect(Gate(operation: GateOperation.subtract10, laneIndex: 0, position: Vector2.zero()).operationText, '-10');
    });
    
    test('Gate has correct color coding', () {
      // Multiply gates are green
      expect(Gate(operation: GateOperation.multiply2, laneIndex: 0, position: Vector2.zero()).gateColor, Colors.green);
      expect(Gate(operation: GateOperation.multiply3, laneIndex: 0, position: Vector2.zero()).gateColor, Colors.green);
      
      // Add gates are blue
      expect(Gate(operation: GateOperation.add10, laneIndex: 0, position: Vector2.zero()).gateColor, Colors.blue);
      expect(Gate(operation: GateOperation.add20, laneIndex: 0, position: Vector2.zero()).gateColor, Colors.blue);
      
      // Subtract gates are red
      expect(Gate(operation: GateOperation.subtract10, laneIndex: 0, position: Vector2.zero()).gateColor, Colors.red);
    });
  });
}
