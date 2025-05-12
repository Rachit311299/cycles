import 'package:cycles/models/cycle_stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import '../providers/cycle_provider.dart';
import '../services/asset_preloader_service.dart';
import './custom_button.dart';
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
  final AudioPlayer _audioPlayer = AudioPlayer(); // For pronunciation
  List<AudioPlayer>? _explanationPlayers;
  int _lastPlayedStageIndex = -1;
  String? _errorMessage;
  bool _isExplanationPlaying = false;
  int? _currentExplanationIndex;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayers();
  }

  void _initializeAudioPlayers() {
    _explanationPlayers = AssetPreloaderService().getPreloadedPlayers(widget.cycleType);
    
    if (_explanationPlayers != null) {
      for (int i = 0; i < _explanationPlayers!.length; i++) {
        _explanationPlayers![i].playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed && mounted) {
            setState(() {
              if (_currentExplanationIndex == i) {
                _isExplanationPlaying = false;
                _currentExplanationIndex = null;
              }
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

  Future<void> _toggleExplanationAudio(int stageIndex) async {
    if (_explanationPlayers == null || stageIndex >= _explanationPlayers!.length) return;

    // If already playing this stage's explanation
    if (_isExplanationPlaying && _currentExplanationIndex == stageIndex) {
      // Pause it
      _explanationPlayers![stageIndex].pause();
      setState(() {
        _isExplanationPlaying = false;
      });
      return;
    }

    // Stop any currently playing explanation audio
    if (_isExplanationPlaying && _currentExplanationIndex != null) {
      _explanationPlayers![_currentExplanationIndex!].stop();
    }

    try {
      // Start the new explanation audio
      await _explanationPlayers![stageIndex].seek(Duration.zero);
      await _explanationPlayers![stageIndex].play();

      setState(() {
        _isExplanationPlaying = true;
        _currentExplanationIndex = stageIndex;
        _lastPlayedStageIndex = stageIndex;
      });
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

  Future<void> _playAudio(String audioAsset, String language) async {
    try {
      // Pause explanation audio if it's playing
      if (_isExplanationPlaying && _currentExplanationIndex != null) {
        _explanationPlayers![_currentExplanationIndex!].pause();
      }

      await _audioPlayer.setAsset(audioAsset);
      await _audioPlayer.play();

      // Resume explanation audio after pronunciation is done
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

        // Auto-hide error after 3 seconds
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
    // Check if animation asset is available
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
                // GIFs are automatically animated when loaded with Image.asset
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading animation: $error');
                  // Fallback to static image if animation fails to load
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
      // Use static image as fallback
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

    // Check if stage has changed - stop audio if it was playing
    if (currentStageIndex != _lastPlayedStageIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _stopAllAudio();

        // Don't auto-play, just update the index
        _lastPlayedStageIndex = currentStageIndex;
      });
    }

    // Boundary check
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
      // Make sure audio stops when using system back button
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
                  // Top bar with close button and progress bar
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

                  // Main content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          // Stage image with play/pause audio button
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
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.75,
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.4,
                                        child: _buildImageOrAnimation(
                                          currentStage,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Play/Pause Explanation button
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: CustomButton(
                                  height: 40,
                                  width: 140,
                                  cornerRadius: 20,
                                  buttonColor: widget.buttonColor,
                                  onPressed:
                                      () => _toggleExplanationAudio(
                                        currentStageIndex,
                                      ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _isExplanationPlaying &&
                                                _currentExplanationIndex ==
                                                    currentStageIndex
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'Explanation',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'PoetsenOne',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Language sections
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // English section
                              const Center(
                                child: Text(
                                  'English',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Centered text
                                  Center(
                                    child: Text(
                                      currentStage.name,
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontFamily: 'PoetsenOne',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  // Icon positioned to the right
                                  Positioned(
                                    right: 50,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.volume_up,
                                        color: Colors.black87,
                                      ),
                                      onPressed: () {
                                        if (currentStage.audioAssets != null &&
                                            currentStage.audioAssets!
                                                .containsKey('en')) {
                                          _playAudio(
                                            currentStage.audioAssets!['en']!,
                                            'en',
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              // Spanish section
                              const Center(
                                child: Text(
                                  'Spanish',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Centered text
                                  Center(
                                    child: Text(
                                      currentStage.translations['es'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontFamily: 'PoetsenOne',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  // Icon positioned to the right
                                  Positioned(
                                    right: 50,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.volume_up,
                                        color: Colors.black87,
                                      ),
                                      onPressed: () {
                                        if (currentStage.audioAssets != null &&
                                            currentStage.audioAssets!
                                                .containsKey('es')) {
                                          _playAudio(
                                            currentStage.audioAssets!['es']!,
                                            'es',
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Navigation buttons at the bottom
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Previous button
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

                                // Next button or Complete button
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Error message at the bottom
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