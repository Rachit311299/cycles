import 'package:cycles/models/cycle_stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import '../providers/cycle_provider.dart';
import '../services/asset_preloader_service.dart';
import './custom_button.dart';
import 'bottom_switch_card.dart';
import 'dart:async';

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
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<AudioPlayer>? _explanationPlayers;
  int _lastPlayedStageIndex = -1;
  String? _errorMessage;
  bool _isExplanationPlaying = false;
  int? _currentExplanationIndex;
  BottomCardTab _currentTab = BottomCardTab.pronunciation;
  Language _explanationLanguage = Language.en;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayers();
  }

  /// Initialize audio players for explanation audio with live subtitles
  void _initializeAudioPlayers() {
    _explanationPlayers = AssetPreloaderService()
        .getPreloadedPlayers(widget.cycleType, _langCode(_explanationLanguage));
    
    if (_explanationPlayers == null) {
      final cycleNotifier = ref.read(widget.cycleProvider.notifier);
      AssetPreloaderService().preloadCycleAssets(cycleNotifier.stages, widget.cycleType);
      
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _explanationPlayers = AssetPreloaderService()
                .getPreloadedPlayers(widget.cycleType, _langCode(_explanationLanguage));
            _setupPlayerListeners();
          });
        }
      });
    } else {
      _setupPlayerListeners();
    }
  }

  /// Setup listeners for audio completion to update subtitle state
  void _setupPlayerListeners() {
    if (_explanationPlayers != null) {
      for (int i = 0; i < _explanationPlayers!.length; i++) {
        _explanationPlayers![i].playerStateStream.listen((state) {
          if (_currentExplanationIndex == i && 
              state.processingState == ProcessingState.completed && 
              mounted) {
            setState(() {
              _isExplanationPlaying = false;
              _currentExplanationIndex = null;
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CycleView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.cycleProvider != widget.cycleProvider) {
      _stopAllAudio();
      _lastPlayedStageIndex = -1;
    }
  }

  void _stopAllAudio() {
    _audioPlayer.stop();
    if (_explanationPlayers != null) {
      for (var player in _explanationPlayers!) {
        player.stop();
      }
    }
    setState(() {
      _isExplanationPlaying = false;
      _currentExplanationIndex = null;
    });
  }

  /// Toggle explanation audio playback with subtitle synchronization
  Future<void> _toggleExplanationAudio(int stageIndex) async {
    if (_explanationPlayers == null || stageIndex >= _explanationPlayers!.length) return;

    if (!_hasExplanationFor(stageIndex)) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Explanation not available in ${_langCode(_explanationLanguage).toUpperCase()}';
        });
      }
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _errorMessage = null);
        }
      });
      return;
    }

    final player = _explanationPlayers![stageIndex];
    final playerState = player.playerState;

    if (_currentExplanationIndex == stageIndex) {
      if (playerState.playing) {
        if (mounted) {
          setState(() {
            _isExplanationPlaying = false;
          });
        }
        await player.pause();
      } else {
        if (mounted) {
          setState(() {
            _isExplanationPlaying = true;
          });
        }
        await player.play();
      }
      return;
    }

    if (_currentExplanationIndex != null) {
      await _explanationPlayers![_currentExplanationIndex!].stop();
    }

    try {
      if (mounted) {
        setState(() {
          _isExplanationPlaying = true;
          _currentExplanationIndex = stageIndex;
          _lastPlayedStageIndex = stageIndex;
        });
      }
      
      await player.seek(Duration.zero);
      await player.play();
    } catch (e) {
      debugPrint('Error playing explanation audio: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Error playing audio: $e';
          _isExplanationPlaying = false;
          _currentExplanationIndex = null;
        });
      }
    }
  }

  String _langCode(Language lang) => lang == Language.es ? 'es' : 'en';

  /// Check if explanation audio exists for current language
  bool _hasExplanationFor(int index) {
    final cycleNotifier = ref.read(widget.cycleProvider.notifier);
    final stages = cycleNotifier.stages;
    if (index < 0 || index >= stages.length) return false;
    final stage = stages[index];
    final code = _langCode(_explanationLanguage);
    if (stage.explanationAudioAssets != null && stage.explanationAudioAssets!.containsKey(code)) {
      return true;
    }
    if (code == 'en' && stage.explanationAudio != null) return true;
    return false;
  }

  Future<void> _playAudio(String audioAsset, String language) async {
    try {
      if (_isExplanationPlaying && _currentExplanationIndex != null) {
        _explanationPlayers![_currentExplanationIndex!].pause();
      }

      await _audioPlayer.setAsset(audioAsset);
      await _audioPlayer.play();

      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed &&
            _isExplanationPlaying &&
            _currentExplanationIndex != null) {
          _explanationPlayers![_currentExplanationIndex!].play();
        }
      });
    } catch (e) {
      debugPrint('Error playing audio: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Error playing audio: $e';
        });

        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _errorMessage = null;
            });
          }
        });
      }
    }
  }

  Widget _buildImageOrAnimation(CycleStage stage) {
    if (stage.animationAsset != null) {
      return Center(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
              child: Image.asset(
                stage.animationAsset!,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading animation: $error');
                  if (stage.imageAsset.isNotEmpty) {
                    return Image.asset(
                      stage.imageAsset,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    );
                  }
                  return _buildErrorPlaceholder();
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
              child: Image.asset(
                stage.imageAsset,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading image: $error');
                  return _buildErrorPlaceholder();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: widget.imageBackgroundColor.withOpacity(0.15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              'Image not available',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStageIndex = ref.watch(widget.cycleProvider);
    final cycleNotifier = ref.read(widget.cycleProvider.notifier);
    final stages = cycleNotifier.stages;

    if (currentStageIndex != _lastPlayedStageIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _stopAllAudio();
        _lastPlayedStageIndex = currentStageIndex;
      });
    }
    if (currentStageIndex >= stages.length) {
      ref.read(widget.cycleProvider.notifier).reset();
      context.go('/');
      return const SizedBox.shrink();
    }

    final currentStage = stages[currentStageIndex];
    final progress = (currentStageIndex + 1) / stages.length;

    void _handleClose() {
      _stopAllAudio();
      ref.read(widget.cycleProvider.notifier).reset();
      if (context.mounted) {
        context.pop();
      }
    }

    void _handleComplete() {
      _stopAllAudio();
      ref.read(widget.cycleProvider.notifier).reset();
      if (context.mounted) {
        context.pop();
      }
    }

    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          _stopAllAudio();
        }
      },
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black87),
                          onPressed: _handleClose,
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              tween: Tween<double>(
                                begin: 0,
                                end: progress,
                              ),
                              builder: (context, value, child) {
                                return LinearProgressIndicator(
                                  value: value,
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    widget.progressBarColor,
                                  ),
                                  minHeight: 8,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.35,
                                  width: MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    color: widget.imageBackgroundColor.withOpacity(0.3),
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
                                      color: widget.imageBackgroundColor.withOpacity(0.15),
                                      child: Center(
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.75,
                                          height: MediaQuery.of(context).size.height * 0.32,
                                          child: _buildImageOrAnimation(currentStage),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 2,
                              decoration: BoxDecoration(
                                color: widget.buttonColor.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                            const SizedBox(height: 16),
                            BottomSwitchCard(
                              accentColor: widget.buttonColor,
                              tab: _currentTab,
                              widthFactor: 0.9,
                              pronunciation: PronunciationData(
                                englishWord: currentStage.name,
                                spanishWord: currentStage.translations['es'] ?? '',
                                hasEnglishAudio: currentStage.audioAssets?.containsKey('en') == true,
                                hasSpanishAudio: currentStage.audioAssets?.containsKey('es') == true,
                              ),
                              // Pass audio player and subtitle path for live subtitles
                              explanation: ExplanationData(
                                englishText: currentStage.description,
                                spanishText: currentStage.description,
                                selectedLanguage: _explanationLanguage,
                                audioPlayer: _explanationPlayers != null && currentStageIndex < _explanationPlayers!.length 
                                    ? _explanationPlayers![currentStageIndex] 
                                    : null,
                                subtitlesPath: currentStage.explanationSubtitles,
                              ),
                              onExplanationLanguageChanged: (lang) {
                                final wasPlaying = _isExplanationPlaying;
                                final currentIndex = _currentExplanationIndex;

                                if (_explanationPlayers != null && currentIndex != null) {
                                  _explanationPlayers![currentIndex].pause();
                                }

                                setState(() {
                                  _explanationLanguage = lang;
                                  _isExplanationPlaying = false;
                                });

                                final code = _langCode(lang);
                                final newPlayers = AssetPreloaderService()
                                    .getPreloadedPlayers(widget.cycleType, code);
                                if (newPlayers != null) {
                                  setState(() {
                                    _explanationPlayers = newPlayers;
                                  });
                                  _setupPlayerListeners();
                                  if (wasPlaying && currentIndex != null && currentIndex < newPlayers.length) {
                                    _toggleExplanationAudio(currentIndex);
                                  }
                                } else {
                                  Future.delayed(const Duration(milliseconds: 300), () {
                                    if (!mounted) return;
                                    final readyPlayers = AssetPreloaderService()
                                        .getPreloadedPlayers(widget.cycleType, code);
                                    if (readyPlayers != null) {
                                      setState(() {
                                        _explanationPlayers = readyPlayers;
                                      });
                                      _setupPlayerListeners();
                                      if (wasPlaying && currentIndex != null && currentIndex < readyPlayers.length) {
                                        _toggleExplanationAudio(currentIndex);
                                      }
                                    }
                                  });
                                }
                              },
                              onPlayEnglishPronunciation: () {
                                if (currentStage.audioAssets != null &&
                                    currentStage.audioAssets!.containsKey('en')) {
                                  _playAudio(currentStage.audioAssets!['en']!, 'en');
                                }
                              },
                              onPlaySpanishPronunciation: () {
                                if (currentStage.audioAssets != null &&
                                    currentStage.audioAssets!.containsKey('es')) {
                                  _playAudio(currentStage.audioAssets!['es']!, 'es');
                                }
                              },
                              isExplanationPlaying: _isExplanationPlaying && _currentExplanationIndex == currentStageIndex,
                              onToggleExplanationPlay: () => _toggleExplanationAudio(currentStageIndex),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (currentStageIndex > 0)
                                    CustomButton(
                                      height: 56,
                                      width: 56,
                                      cornerRadius: 12,
                                      buttonColor: widget.buttonColor,
                                      icon: Icons.arrow_back_ios_new,
                                      onPressed: () {
                                        _stopAllAudio();
                                        cycleNotifier.previousStage();
                                      },
                                    )
                                  else
                                    const SizedBox(width: 56),
                                  if (currentStageIndex < stages.length - 1)
                                    CustomButton(
                                      height: 56,
                                      width: 56,
                                      cornerRadius: 12,
                                      buttonColor: widget.buttonColor,
                                      icon: Icons.arrow_forward_ios,
                                      onPressed: () {
                                        _stopAllAudio();
                                        cycleNotifier.nextStage();
                                      },
                                    )
                                  else
                                    CustomButton(
                                      height: 56,
                                      width: 120,
                                      cornerRadius: 12,
                                      buttonColor: widget.buttonColor,
                                      text: 'Complete',
                                      onPressed: _handleComplete,
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              if (_errorMessage != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}