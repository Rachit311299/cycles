import 'package:flutter/material.dart';

/// Represents a game completion result
class GameResult {
  final String gameType; // 'trivia' or 'builder'
  final String cycleType; // 'plant', 'water', 'rock', 'season', 'butterfly', 'frog'
  final double score; // 0.0 to 1.0
  final int xpEarned;
  final DateTime timestamp;
  final bool isFirstTime;

  const GameResult({
    required this.gameType,
    required this.cycleType,
    required this.score,
    required this.xpEarned,
    required this.timestamp,
    required this.isFirstTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'gameType': gameType,
      'cycleType': cycleType,
      'score': score,
      'xpEarned': xpEarned,
      'timestamp': timestamp.toIso8601String(),
      'isFirstTime': isFirstTime,
    };
  }

  factory GameResult.fromJson(Map<String, dynamic> json) {
    return GameResult(
      gameType: json['gameType'] as String,
      cycleType: json['cycleType'] as String,
      score: (json['score'] as num).toDouble(),
      xpEarned: json['xpEarned'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isFirstTime: json['isFirstTime'] as bool,
    );
  }
}

/// Represents an achievement/badge
class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final Color color;
  final DateTime? unlockedAt;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.color,
    this.unlockedAt,
  });

  Achievement copyWith({DateTime? unlockedAt}) {
    return Achievement(
      id: id,
      title: title,
      description: description,
      iconName: iconName,
      color: color,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  bool get isUnlocked => unlockedAt != null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconName': iconName,
      'color': color.value,
      'unlockedAt': unlockedAt?.toIso8601String(),
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconName: json['iconName'] as String,
      color: Color(json['color'] as int),
      unlockedAt: json['unlockedAt'] != null 
          ? DateTime.parse(json['unlockedAt'] as String) 
          : null,
    );
  }
}

/// Main XP data container
class XPData {
  final int totalXP;
  final int currentLevel;
  final int gamesPlayed;
  final List<String> unlockedAchievementIds;
  final List<GameResult> gameHistory;
  final Map<String, bool> firstTimeCompletions; // gameType_cycleType -> bool

  const XPData({
    required this.totalXP,
    required this.currentLevel,
    required this.gamesPlayed,
    required this.unlockedAchievementIds,
    required this.gameHistory,
    required this.firstTimeCompletions,
  });

  XPData copyWith({
    int? totalXP,
    int? currentLevel,
    int? gamesPlayed,
    List<String>? unlockedAchievementIds,
    List<GameResult>? gameHistory,
    Map<String, bool>? firstTimeCompletions,
  }) {
    return XPData(
      totalXP: totalXP ?? this.totalXP,
      currentLevel: currentLevel ?? this.currentLevel,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      unlockedAchievementIds: unlockedAchievementIds ?? this.unlockedAchievementIds,
      gameHistory: gameHistory ?? this.gameHistory,
      firstTimeCompletions: firstTimeCompletions ?? this.firstTimeCompletions,
    );
  }

  /// Calculate XP needed for next level
  int get xpForNextLevel {
    return _getXPRequiredForLevel(currentLevel + 1) - totalXP;
  }

  /// Calculate XP progress within current level
  int get xpInCurrentLevel {
    return totalXP - _getXPRequiredForLevel(currentLevel);
  }

  /// Calculate total XP needed for current level
  int get xpRequiredForCurrentLevel {
    return _getXPRequiredForLevel(currentLevel + 1) - _getXPRequiredForLevel(currentLevel);
  }

  /// Get XP required for a specific level
  static int _getXPRequiredForLevel(int level) {
    switch (level) {
      case 1: return 0;      // Beginner
      case 2: return 100;    // Explorer
      case 3: return 250;    // Scholar
      case 4: return 500;    // Expert
      case 5: return 1000;   // Master
      default: return 1000;  // Cap at Master level
    }
  }

  /// Get level name
  String get levelName {
    switch (currentLevel) {
      case 1: return 'Beginner';
      case 2: return 'Explorer';
      case 3: return 'Scholar';
      case 4: return 'Expert';
      case 5: return 'Master';
      default: return 'Beginner';
    }
  }

  /// Get level color
  Color get levelColor {
    switch (currentLevel) {
      case 1: return Colors.grey;
      case 2: return Colors.green;
      case 3: return Colors.blue;
      case 4: return Colors.purple;
      case 5: return Colors.amber;
      default: return Colors.grey;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'totalXP': totalXP,
      'currentLevel': currentLevel,
      'gamesPlayed': gamesPlayed,
      'unlockedAchievementIds': unlockedAchievementIds,
      'gameHistory': gameHistory.map((result) => result.toJson()).toList(),
      'firstTimeCompletions': firstTimeCompletions,
    };
  }

  factory XPData.fromJson(Map<String, dynamic> json) {
    return XPData(
      totalXP: json['totalXP'] as int? ?? 0,
      currentLevel: json['currentLevel'] as int? ?? 1,
      gamesPlayed: json['gamesPlayed'] as int? ?? 0,
      unlockedAchievementIds: (json['unlockedAchievementIds'] as List<dynamic>?)
          ?.map((id) => id as String)
          .toList() ?? [],
      gameHistory: (json['gameHistory'] as List<dynamic>?)
          ?.map((result) => GameResult.fromJson(result as Map<String, dynamic>))
          .toList() ?? [],
      firstTimeCompletions: Map<String, bool>.from(
          json['firstTimeCompletions'] as Map<String, dynamic>? ?? {}),
    );
  }

  /// Create initial XP data
  factory XPData.initial() {
    return const XPData(
      totalXP: 0,
      currentLevel: 1,
      gamesPlayed: 0,
      unlockedAchievementIds: [],
      gameHistory: [],
      firstTimeCompletions: {},
    );
  }
}

/// XP calculation utilities
class XPCalculator {
  /// Calculate XP for trivia games based on score percentage
  static int calculateTriviaXP(double percentage, bool isFirstTime) {
    int baseXP = switch (percentage) {
      >= 1.0 => 50,  // Perfect
      >= 0.9 => 40,  // Excellent  
      >= 0.7 => 30,  // Good
      >= 0.5 => 20,  // Fair
      _ => 10,       // Poor
    };
    return baseXP + (isFirstTime ? 10 : 0);
  }

  /// Calculate XP for builder games based on completion percentage
  static int calculateBuilderXP(double percentage, bool isFirstTime) {
    int baseXP = switch (percentage) {
      >= 1.0 => 40,  // Perfect
      >= 0.8 => 25,  // Good
      _ => 15,       // Partial
    };
    return baseXP + (isFirstTime ? 10 : 0);
  }

  /// Calculate level based on total XP
  static int calculateLevel(int totalXP) {
    if (totalXP >= 1000) return 5;      // Master
    if (totalXP >= 500) return 4;       // Expert
    if (totalXP >= 250) return 3;       // Scholar
    if (totalXP >= 100) return 2;       // Explorer
    return 1;                           // Beginner
  }
}

/// Achievement definitions
class AchievementDefinitions {
  static const List<Achievement> allAchievements = [
    Achievement(
      id: 'first_perfect_trivia',
      title: 'Perfect Score',
      description: 'Get a perfect score in any trivia game',
      iconName: 'star',
      color: Colors.amber,
    ),
    Achievement(
      id: 'first_perfect_builder',
      title: 'Master Builder',
      description: 'Complete a cycle builder game perfectly',
      iconName: 'construction',
      color: Colors.orange,
    ),
    Achievement(
      id: '10_games_completed',
      title: 'Dedicated Learner',
      description: 'Complete 10 games',
      iconName: 'school',
      color: Colors.blue,
    ),
    Achievement(
      id: '25_games_completed',
      title: 'Learning Champion',
      description: 'Complete 25 games',
      iconName: 'emoji_events',
      color: Colors.purple,
    ),
    Achievement(
      id: 'all_cycles_mastered',
      title: 'Cycle Master',
      description: 'Play games for all cycle types',
      iconName: 'all_inclusive',
      color: Colors.green,
    ),
    Achievement(
      id: 'level_5_master',
      title: 'Ultimate Master',
      description: 'Reach level 5 (Master)',
      iconName: 'military_tech',
      color: Colors.red,
    ),
  ];

  static Achievement? getAchievementById(String id) {
    try {
      return allAchievements.firstWhere((achievement) => achievement.id == id);
    } catch (e) {
      return null;
    }
  }
}
