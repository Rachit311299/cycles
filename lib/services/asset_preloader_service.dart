import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../models/cycle_stage.dart';

class AssetPreloaderService {
  static final AssetPreloaderService _instance = AssetPreloaderService._internal();
  factory AssetPreloaderService() => _instance;
  AssetPreloaderService._internal();

  final Map<String, List<AudioPlayer>> _preloadedAudioPlayers = {};
  bool _isPreloading = false;

  Future<void> preloadCycleAssets(List<CycleStage> stages, String cycleType) async {
    if (_isPreloading) return;
    _isPreloading = true;

    try {
      // Start preloading in a separate isolate
      await compute(_preloadAssetsInBackground, {
        'stages': stages,
        'cycleType': cycleType,
      });
    } catch (e) {
      debugPrint('Error preloading assets: $e');
    } finally {
      _isPreloading = false;
    }
  }

  void disposeCycleAssets(String cycleType) {
    if (_preloadedAudioPlayers.containsKey(cycleType)) {
      for (var player in _preloadedAudioPlayers[cycleType]!) {
        player.dispose();
      }
      _preloadedAudioPlayers.remove(cycleType);
    }
  }

  List<AudioPlayer>? getPreloadedPlayers(String cycleType) {
    return _preloadedAudioPlayers[cycleType];
  }
}

Future<void> _preloadAssetsInBackground(Map<String, dynamic> params) async {
  final List<CycleStage> stages = params['stages'];
  final String cycleType = params['cycleType'];
  final List<AudioPlayer> players = [];

  for (int i = 0; i < stages.length; i++) {
    final stage = stages[i];
    final explanationPath = _getExplanationPath(stage, i, cycleType);

    final player = AudioPlayer();
    await player.setAsset(explanationPath);
    players.add(player);
  }

  AssetPreloaderService()._preloadedAudioPlayers[cycleType] = players;
}

String _getExplanationPath(CycleStage stage, int index, String cycleType) {
  if (stage.explanationAudio != null) {
    return stage.explanationAudio!;
  }
  return 'assets/audio/${cycleType}_cycle/stages/${cycleType.toUpperCase()}EX-S${index + 1}-${stage.name.replaceAll(' ', '')}.mp3';
} 