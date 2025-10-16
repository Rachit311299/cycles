import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../models/cycle_stage.dart';

class AssetPreloaderService {
  static final AssetPreloaderService _instance = AssetPreloaderService._internal();
  factory AssetPreloaderService() => _instance;
  AssetPreloaderService._internal();

  // cycleType -> language ('en'/'es') -> players list
  final Map<String, Map<String, List<AudioPlayer>>> _preloadedAudioPlayersByCycle = {};
  final Map<String, bool> _isPreloadingMap = {};

  Future<void> preloadCycleAssets(List<CycleStage> stages, String cycleType) async {
    // Skip if already preloaded or currently preloading this cycle
    if (_preloadedAudioPlayersByCycle.containsKey(cycleType) ||
        _isPreloadingMap[cycleType] == true) {
      debugPrint('$cycleType already preloaded or preloading, skipping');
      return;
    }

    _isPreloadingMap[cycleType] = true;

    // Run preloading in background without blocking
    _preloadInBackground(stages, cycleType);
  }

  Future<void> _preloadInBackground(List<CycleStage> stages, String cycleType) async {
    try {
      debugPrint('Starting background preload for $cycleType cycle');

      final Map<String, List<AudioPlayer>> playersByLang = {};
      final List<String> languagesToPreload = ['en', 'es'];

      for (final lang in languagesToPreload) {
        final List<AudioPlayer> playersForLang = [];
        for (int i = 0; i < stages.length; i++) {
          final stage = stages[i];
          final explanationPath = _resolveExplanationPath(stage, i, cycleType, lang);

          if (explanationPath == null) {
            // Maintain positional alignment with a placeholder player
            playersForLang.add(AudioPlayer());
            continue;
          }

          final player = AudioPlayer();
          try {
            await player.setAsset(explanationPath);
            playersForLang.add(player);
            debugPrint('Preloaded ($lang) ${i + 1}/${stages.length} for $cycleType');
          } catch (e) {
            debugPrint('Error loading explanation audio ($lang) for ${stage.name}: $e');
            playersForLang.add(player); // Keep index alignment
          }
        }
        playersByLang[lang] = playersForLang;
      }

      _preloadedAudioPlayersByCycle[cycleType] = playersByLang;
      debugPrint('✅ Successfully preloaded explanation audio (en/es) for $cycleType cycle');
    } catch (e) {
      debugPrint('❌ Error preloading assets for $cycleType: $e');
    } finally {
      _isPreloadingMap[cycleType] = false;
    }
  }

  void disposeCycleAssets(String cycleType) {
    final byLang = _preloadedAudioPlayersByCycle.remove(cycleType);
    if (byLang != null) {
      for (final players in byLang.values) {
        for (final p in players) {
          p.dispose();
        }
      }
    }
  }

  List<AudioPlayer>? getPreloadedPlayers(String cycleType, String language) {
    return _preloadedAudioPlayersByCycle[cycleType]?[language];
  }
}

String? _resolveExplanationPath(CycleStage stage, int index, String cycleType, String language) {
  // Prefer explicit localized assets if provided
  final localized = stage.explanationAudioAssets;
  if (localized != null && localized.containsKey(language)) {
    return localized[language]!;
  }

  // Fallback to legacy single path for English only
  if (language == 'en' && stage.explanationAudio != null) {
    return stage.explanationAudio!;
  }

  // No known path
  return null;
}