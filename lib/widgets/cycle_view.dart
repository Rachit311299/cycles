import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

import '../models/cycle_stage.dart';
import '../providers/cycle_provider.dart';
import './custom_button.dart';

class CycleView extends ConsumerStatefulWidget {
  final String title;
  final Color backgroundColor;
  final Color progressBarColor;
  final Color imageBackgroundColor;
  final Color buttonColor;
  final String cycleType;
  final StateNotifierProvider<CycleNotifier, int> cycleProvider;

  const CycleView({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.progressBarColor,
    required this.imageBackgroundColor,
    required this.buttonColor,
    required this.cycleType,
    required this.cycleProvider,
  }) : super(key: key);

  @override
  ConsumerState<CycleView> createState() => _CycleViewState();
}

class _CycleViewState extends ConsumerState<CycleView> {
  // Audio
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<AudioPlayer> _explanationPlayers = [];
  bool _isExplanationPlaying = false;
  int? _currentExplanationIndex;

  // Loading & error
  bool _isLoading = true;
  String? _errorMessage;

  // Track last stage to reset audio on change
  int _lastPlayedStageIndex = -1;

  @override
  void initState() {
    super.initState();
    _preloadAudio();
  }

  Future<void> _preloadAudio() async {
    setState(() => _isLoading = true);

    try {
      final notifier = ref.read(widget.cycleProvider.notifier);
      final stages = notifier.stages;

      // Preload explanation audio for each stage
      for (var i = 0; i < stages.length; i++) {
        final path = _getExplanationPath(stages[i], i);
        final player = AudioPlayer();
        await player.setAsset(path);
        player.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed && mounted) {
            if (_currentExplanationIndex == i) {
              setState(() {
                _isExplanationPlaying = false;
                _currentExplanationIndex = null;
              });
            }
          }
        });
        _explanationPlayers.add(player);
      }

      _lastPlayedStageIndex = ref.read(widget.cycleProvider);
    } catch (e) {
      debugPrint('Audio preload error: $e');
      setState(() => _errorMessage = 'Error loading audio: $e');
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _errorMessage = null);
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getExplanationPath(CycleStage s, int i) =>
      s.explanationAudio ??
      'assets/audio/${widget.cycleType}_cycle/stages/'
      '${widget.cycleType.toUpperCase()}EX-S${i + 1}-'
      '${s.name.replaceAll(' ', '')}.mp3';

  void _stopAllAudio() {
    _audioPlayer.stop();
    for (var p in _explanationPlayers) p.stop();
    setState(() {
      _isExplanationPlaying = false;
      _currentExplanationIndex = null;
    });
  }

  Future<void> _toggleExplanationAudio(int idx) async {
    if (idx >= _explanationPlayers.length) return;
    final player = _explanationPlayers[idx];

    if (_isExplanationPlaying && _currentExplanationIndex == idx) {
      await player.pause();
      setState(() => _isExplanationPlaying = false);
      return;
    }

    if (_isExplanationPlaying && _currentExplanationIndex != null) {
      _explanationPlayers[_currentExplanationIndex!].stop();
    }

    try {
      await player.seek(Duration.zero);
      await player.play();
      setState(() {
        _isExplanationPlaying = true;
        _currentExplanationIndex = idx;
      });
    } catch (e) {
      debugPrint('Audio play error: $e');
      setState(() => _errorMessage = 'Error playing audio');
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _errorMessage = null);
      });
    }
  }

  Future<void> _playAudio(String asset, String lang) async {
    if (_isExplanationPlaying && _currentExplanationIndex != null) {
      _explanationPlayers[_currentExplanationIndex!].pause();
    }
    try {
      await _audioPlayer.setAsset(asset);
      await _audioPlayer.play();
      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed &&
            _isExplanationPlaying &&
            _currentExplanationIndex != null) {
          _explanationPlayers[_currentExplanationIndex!].play();
        }
      });
    } catch (e) {
      debugPrint('Pronunciation error: $e');
      setState(() => _errorMessage = 'Error playing pronunciation');
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _errorMessage = null);
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    for (var p in _explanationPlayers) p.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(widget.cycleProvider);
    final notifier = ref.read(widget.cycleProvider.notifier);
    final stages = notifier.stages;

    // On stage change, stop any playing audio
    if (currentIndex != _lastPlayedStageIndex && !_isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _stopAllAudio();
        _lastPlayedStageIndex = currentIndex;
      });
    }

    // If we’ve run out of stages, reset and exit
    if (currentIndex >= stages.length) {
      notifier.reset();
      context.go('/');
      return const SizedBox.shrink();
    }

    final stage = stages[currentIndex];
    final progress = (currentIndex + 1) / stages.length;

    void close() {
      _stopAllAudio();
      notifier.reset();
      if (context.mounted) context.pop();
    }

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Top bar with close & progress
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: close,
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            valueColor:
                                AlwaysStoppedAnimation(widget.progressBarColor),
                            minHeight: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                // Main content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Static image + explanation button
                        Stack(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                color: widget.imageBackgroundColor
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: widget.imageBackgroundColor
                                      .withOpacity(0.15),
                                  child: Center(
                                    child: Image.asset(
                                      stage.imageAsset,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(
                                        Icons.image_not_supported,
                                        size: 48,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: CustomButton(
                                height: 40,
                                width: 140,
                                cornerRadius: 20,
                                buttonColor: widget.buttonColor,
                                onPressed: () =>
                                    _toggleExplanationAudio(currentIndex),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _isExplanationPlaying &&
                                              _currentExplanationIndex ==
                                                  currentIndex
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text('Explanation'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // English & Spanish text + pronunciation
                        Column(
                          children: [
                            const Text(
                              'English',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54),
                            ),
                            const SizedBox(height: 4),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  stage.name,
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontFamily: 'PoetsenOne'),
                                ),
                                Positioned(
                                  right: 50,
                                  child: IconButton(
                                    icon: const Icon(Icons.volume_up),
                                    onPressed: () {
                                      final asset =
                                          stage.audioAssets?['en'];
                                      if (asset != null)
                                        _playAudio(asset, 'en');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Spanish',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54),
                            ),
                            const SizedBox(height: 4),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  stage.translations['es'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontFamily: 'PoetsenOne'),
                                ),
                                Positioned(
                                  right: 50,
                                  child: IconButton(
                                    icon: const Icon(Icons.volume_up),
                                    onPressed: () {
                                      final asset =
                                          stage.audioAssets?['es'];
                                      if (asset != null)
                                        _playAudio(asset, 'es');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Navigation buttons
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (currentIndex > 0)
                                CustomButton(
                                  height: 56,
                                  width: 56,
                                  cornerRadius: 12,
                                  buttonColor: widget.buttonColor,
                                  icon: Icons.arrow_back_ios_new,
                                  onPressed: () {
                                    _stopAllAudio();
                                    notifier.previousStage();
                                  },
                                )
                              else
                                const SizedBox(width: 56),
                              if (currentIndex < stages.length - 1)
                                CustomButton(
                                  height: 56,
                                  width: 56,
                                  cornerRadius: 12,
                                  buttonColor: widget.buttonColor,
                                  icon: Icons.arrow_forward_ios,
                                  onPressed: () {
                                    _stopAllAudio();
                                    notifier.nextStage();
                                  },
                                )
                              else
                                CustomButton(
                                  height: 56,
                                  width: 120,
                                  cornerRadius: 12,
                                  buttonColor: widget.buttonColor,
                                  text: 'Complete',
                                  onPressed: close,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Error overlay
            if (_errorMessage != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),

            // Loading overlay
            if (_isLoading)
              Container(
                color: widget.backgroundColor,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
