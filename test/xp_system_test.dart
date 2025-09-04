import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cycles/models/xp_data.dart';

void main() {
  group('XP System Tests', () {
    test('XP Calculator - Trivia XP calculation', () {
      // Test perfect score
      expect(XPCalculator.calculateTriviaXP(1.0, false), equals(50));
      expect(XPCalculator.calculateTriviaXP(1.0, true), equals(60)); // +10 for first time
      
      // Test excellent score
      expect(XPCalculator.calculateTriviaXP(0.95, false), equals(40));
      expect(XPCalculator.calculateTriviaXP(0.95, true), equals(50));
      
      // Test good score
      expect(XPCalculator.calculateTriviaXP(0.8, false), equals(30));
      expect(XPCalculator.calculateTriviaXP(0.8, true), equals(40));
      
      // Test fair score
      expect(XPCalculator.calculateTriviaXP(0.6, false), equals(20));
      expect(XPCalculator.calculateTriviaXP(0.6, true), equals(30));
      
      // Test poor score
      expect(XPCalculator.calculateTriviaXP(0.3, false), equals(10));
      expect(XPCalculator.calculateTriviaXP(0.3, true), equals(20));
    });

    test('XP Calculator - Builder XP calculation', () {
      // Test perfect completion
      expect(XPCalculator.calculateBuilderXP(1.0, false), equals(40));
      expect(XPCalculator.calculateBuilderXP(1.0, true), equals(50));
      
      // Test good completion
      expect(XPCalculator.calculateBuilderXP(0.9, false), equals(25));
      expect(XPCalculator.calculateBuilderXP(0.9, true), equals(35));
      
      // Test partial completion
      expect(XPCalculator.calculateBuilderXP(0.5, false), equals(15));
      expect(XPCalculator.calculateBuilderXP(0.5, true), equals(25));
    });

    test('XP Calculator - Level calculation', () {
      expect(XPCalculator.calculateLevel(0), equals(1));    // Beginner
      expect(XPCalculator.calculateLevel(50), equals(1));   // Beginner
      expect(XPCalculator.calculateLevel(100), equals(2));  // Explorer
      expect(XPCalculator.calculateLevel(200), equals(2));  // Explorer
      expect(XPCalculator.calculateLevel(250), equals(3));  // Scholar
      expect(XPCalculator.calculateLevel(400), equals(3));  // Scholar
      expect(XPCalculator.calculateLevel(500), equals(4));  // Expert
      expect(XPCalculator.calculateLevel(750), equals(4));  // Expert
      expect(XPCalculator.calculateLevel(1000), equals(5)); // Master
      expect(XPCalculator.calculateLevel(1500), equals(5)); // Master (capped)
    });

    test('XPData - Level properties', () {
      final xpData = XPData(
        totalXP: 150,
        currentLevel: 2,
        gamesPlayed: 5,
        unlockedAchievementIds: [],
        gameHistory: [],
        firstTimeCompletions: {},
      );

      expect(xpData.levelName, equals('Explorer'));
      expect(xpData.levelColor, equals(Colors.green));
      expect(xpData.xpInCurrentLevel, equals(50)); // 150 - 100
      expect(xpData.xpRequiredForCurrentLevel, equals(150)); // 250 - 100
      expect(xpData.xpForNextLevel, equals(100)); // 250 - 150
    });

    test('GameResult - JSON serialization', () {
      final gameResult = GameResult(
        gameType: 'trivia',
        cycleType: 'water',
        score: 0.8,
        xpEarned: 30,
        timestamp: DateTime(2024, 1, 15, 10, 30),
        isFirstTime: true,
      );

      final json = gameResult.toJson();
      final restored = GameResult.fromJson(json);

      expect(restored.gameType, equals(gameResult.gameType));
      expect(restored.cycleType, equals(gameResult.cycleType));
      expect(restored.score, equals(gameResult.score));
      expect(restored.xpEarned, equals(gameResult.xpEarned));
      expect(restored.isFirstTime, equals(gameResult.isFirstTime));
    });

    test('XPData - JSON serialization', () {
      final gameResult = GameResult(
        gameType: 'trivia',
        cycleType: 'water',
        score: 0.8,
        xpEarned: 30,
        timestamp: DateTime.now(),
        isFirstTime: true,
      );

      final xpData = XPData(
        totalXP: 150,
        currentLevel: 2,
        gamesPlayed: 5,
        unlockedAchievementIds: ['first_perfect_trivia'],
        gameHistory: [gameResult],
        firstTimeCompletions: {'trivia_water': true},
      );

      final json = xpData.toJson();
      final restored = XPData.fromJson(json);

      expect(restored.totalXP, equals(xpData.totalXP));
      expect(restored.currentLevel, equals(xpData.currentLevel));
      expect(restored.gamesPlayed, equals(xpData.gamesPlayed));
      expect(restored.unlockedAchievementIds, equals(xpData.unlockedAchievementIds));
      expect(restored.gameHistory.length, equals(xpData.gameHistory.length));
      expect(restored.firstTimeCompletions, equals(xpData.firstTimeCompletions));
    });

    test('Achievement - JSON serialization', () {
      final achievement = Achievement(
        id: 'test_achievement',
        title: 'Test Achievement',
        description: 'This is a test achievement',
        iconName: 'star',
        color: Colors.amber,
        unlockedAt: DateTime(2024, 1, 15),
      );

      final json = achievement.toJson();
      final restored = Achievement.fromJson(json);

      expect(restored.id, equals(achievement.id));
      expect(restored.title, equals(achievement.title));
      expect(restored.description, equals(achievement.description));
      expect(restored.iconName, equals(achievement.iconName));
      expect(restored.color.value, equals(achievement.color.value));
      expect(restored.unlockedAt, equals(achievement.unlockedAt));
      expect(restored.isUnlocked, equals(achievement.isUnlocked));
    });
  });
}
