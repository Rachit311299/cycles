import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/xp_data.dart';
import '../services/xp_storage_service.dart';

/// Provider for XP storage service
final xpStorageServiceProvider = Provider<XPStorageService>((ref) {
  return XPStorageService();
});

/// Provider for XP data state
final xpDataProvider = StateNotifierProvider<XPDataNotifier, XPData>((ref) {
  final storageService = ref.watch(xpStorageServiceProvider);
  return XPDataNotifier(storageService);
});

/// State notifier for managing XP data
class XPDataNotifier extends StateNotifier<XPData> {
  final XPStorageService _storageService;
  bool _isInitialized = false;

  XPDataNotifier(this._storageService) : super(XPData.initial()) {
    _initialize();
  }

  /// Initialize XP data from storage
  Future<void> _initialize() async {
    if (_isInitialized) return;
    
    try {
      final xpData = await _storageService.loadXPData();
      state = xpData;
      _isInitialized = true;
    } catch (e) {
      // If loading fails, keep initial state
      print('Failed to load XP data: $e');
      _isInitialized = true;
    }
  }

  /// Add XP from a game result
  Future<void> addGameResult(GameResult gameResult) async {
    try {
      // Calculate new total XP
      final newTotalXP = state.totalXP + gameResult.xpEarned;
      
      // Calculate new level
      final newLevel = XPCalculator.calculateLevel(newTotalXP);
      
      // Check for level up
      final leveledUp = newLevel > state.currentLevel;
      
      // Update first time completions
      final gameKey = '${gameResult.gameType}_${gameResult.cycleType}';
      final updatedFirstTimeCompletions = Map<String, bool>.from(state.firstTimeCompletions);
      updatedFirstTimeCompletions[gameKey] = gameResult.isFirstTime;
      
      // Update game history (keep last 50 games)
      final updatedGameHistory = List<GameResult>.from(state.gameHistory)
        ..add(gameResult);
      if (updatedGameHistory.length > 50) {
        updatedGameHistory.removeAt(0);
      }
      
      // Create new state
      var newState = state.copyWith(
        totalXP: newTotalXP,
        currentLevel: newLevel,
        gamesPlayed: state.gamesPlayed + 1,
        gameHistory: updatedGameHistory,
        firstTimeCompletions: updatedFirstTimeCompletions,
      );
      
      // Check for new achievements
      final newAchievements = _checkForNewAchievements(newState);
      if (newAchievements.isNotEmpty) {
        final updatedAchievementIds = List<String>.from(state.unlockedAchievementIds)
          ..addAll(newAchievements.map((a) => a.id));
        
        newState = newState.copyWith(
          unlockedAchievementIds: updatedAchievementIds,
        );
      }
      
      // Update state
      state = newState;
      
      // Save to storage
      await _storageService.saveXPData(state);
      
      // Notify about level up and achievements
      if (leveledUp) {
        _notifyLevelUp(newLevel);
      }
      
      if (newAchievements.isNotEmpty) {
        _notifyAchievementsUnlocked(newAchievements);
      }
      
    } catch (e) {
      print('Failed to add game result: $e');
      rethrow;
    }
  }

  /// Check for new achievements based on current state
  List<Achievement> _checkForNewAchievements(XPData currentState) {
    final newAchievements = <Achievement>[];
    
    for (final achievement in AchievementDefinitions.allAchievements) {
      // Skip if already unlocked
      if (currentState.unlockedAchievementIds.contains(achievement.id)) {
        continue;
      }
      
      // Check achievement conditions
      if (_isAchievementUnlocked(achievement, currentState)) {
        newAchievements.add(achievement.copyWith(unlockedAt: DateTime.now()));
      }
    }
    
    return newAchievements;
  }

  /// Check if a specific achievement should be unlocked
  bool _isAchievementUnlocked(Achievement achievement, XPData currentState) {
    switch (achievement.id) {
      case 'first_perfect_trivia':
        return currentState.gameHistory.any((result) => 
            result.gameType == 'trivia' && result.score >= 1.0);
      
      case 'first_perfect_builder':
        return currentState.gameHistory.any((result) => 
            result.gameType == 'builder' && result.score >= 1.0);
      
      case '10_games_completed':
        return currentState.gamesPlayed >= 10;
      
      case '25_games_completed':
        return currentState.gamesPlayed >= 25;
      
      case 'all_cycles_mastered':
        final cycleTypes = currentState.gameHistory
            .map((result) => result.cycleType)
            .toSet();
        return cycleTypes.length >= 6; // All 6 cycle types
      
      case 'level_5_master':
        return currentState.currentLevel >= 5;
      
      default:
        return false;
    }
  }

  /// Get all achievements with unlock status
  List<Achievement> getAllAchievements() {
    return AchievementDefinitions.allAchievements.map((achievement) {
      final isUnlocked = state.unlockedAchievementIds.contains(achievement.id);
      if (isUnlocked) {
        // Find when it was unlocked from game history
        final unlockTime = _findAchievementUnlockTime(achievement.id);
        return achievement.copyWith(unlockedAt: unlockTime);
      }
      return achievement;
    }).toList();
  }

  /// Find when an achievement was unlocked
  DateTime? _findAchievementUnlockTime(String achievementId) {
    // This is a simplified approach - in a real app you might want to store
    // achievement unlock times separately
    final gameHistory = state.gameHistory;
    if (gameHistory.isEmpty) return null;
    
    // For now, return the timestamp of the last game that would have triggered this achievement
    switch (achievementId) {
      case 'first_perfect_trivia':
        final perfectTrivia = gameHistory.where((result) => 
            result.gameType == 'trivia' && result.score >= 1.0).toList();
        return perfectTrivia.isNotEmpty ? perfectTrivia.last.timestamp : null;
      
      case 'first_perfect_builder':
        final perfectBuilder = gameHistory.where((result) => 
            result.gameType == 'builder' && result.score >= 1.0).toList();
        return perfectBuilder.isNotEmpty ? perfectBuilder.last.timestamp : null;
      
      case '10_games_completed':
        return gameHistory.length >= 10 ? gameHistory[9].timestamp : null;
      
      case '25_games_completed':
        return gameHistory.length >= 25 ? gameHistory[24].timestamp : null;
      
      case 'level_5_master':
        final level5Games = gameHistory.where((result) => 
            XPCalculator.calculateLevel(state.totalXP - result.xpEarned) < 5 &&
            XPCalculator.calculateLevel(state.totalXP) >= 5).toList();
        return level5Games.isNotEmpty ? level5Games.last.timestamp : null;
      
      default:
        return null;
    }
  }

  /// Reset all XP data
  Future<void> resetXPData() async {
    try {
      await _storageService.resetXPData();
      state = XPData.initial();
    } catch (e) {
      print('Failed to reset XP data: $e');
      rethrow;
    }
  }

  /// Export XP data
  Future<String> exportXPData() async {
    try {
      return await _storageService.exportXPData();
    } catch (e) {
      print('Failed to export XP data: $e');
      rethrow;
    }
  }

  /// Import XP data
  Future<void> importXPData(String jsonString) async {
    try {
      await _storageService.importXPData(jsonString);
      // Reload data from storage
      final xpData = await _storageService.loadXPData();
      state = xpData;
    } catch (e) {
      print('Failed to import XP data: $e');
      rethrow;
    }
  }

  /// Notify about level up (this could trigger UI notifications)
  void _notifyLevelUp(int newLevel) {
    // This could be extended to show level up notifications
    print('Level up! New level: $newLevel');
  }

  /// Notify about achievements unlocked (this could trigger UI notifications)
  void _notifyAchievementsUnlocked(List<Achievement> achievements) {
    // This could be extended to show achievement notifications
    for (final achievement in achievements) {
      print('Achievement unlocked: ${achievement.title}');
    }
  }
}

/// Provider for checking if user leveled up (for UI notifications)
final levelUpProvider = StateProvider<bool>((ref) => false);

/// Provider for newly unlocked achievements (for UI notifications)
final newAchievementsProvider = StateProvider<List<Achievement>>((ref) => []);
