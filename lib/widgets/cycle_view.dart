import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cycle_provider.dart';
import './custom_button.dart';

class CycleView extends ConsumerWidget {
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

  Widget _buildImage(String imageAsset) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: imageBackgroundColor.withOpacity(0.15),
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
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStageIndex = ref.watch(cycleProvider);
    final cycleNotifier = ref.read(cycleProvider.notifier);
    final stages = cycleNotifier.stages;
    
    // Add null check and boundary check
    if (currentStageIndex >= stages.length) {
      ref.read(cycleProvider.notifier).reset();
      context.go('/');
      return const SizedBox.shrink();
    }

    final currentStage = stages[currentStageIndex];
    final progress = (currentStageIndex + 1) / stages.length;

    void _handleClose() {
      ref.read(cycleProvider.notifier).reset();
      if (context.mounted) {
        context.pop();
      }
    }

    void _handleComplete() {
      ref.read(cycleProvider.notifier).reset();
      if (context.mounted) {
        context.pop();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
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
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progressBarColor,
                        ),
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Stage image - increased height
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: imageBackgroundColor.withOpacity(0.3),
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
                          color: imageBackgroundColor.withOpacity(0.15),
                          child: Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: _buildImage(currentStage.imageAsset),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Language sections
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // English section
                        Column(
                          children: [
                            const Text(
                              'English',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentStage.name,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'PoetsenOne',
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.volume_up),
                                  onPressed: () {
                                    // TODO: Implement audio playback
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Spanish section
                        Column(
                          children: [
                            const Text(
                              'Spanish',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentStage.translations['es'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'PoetsenOne',
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.volume_up),
                                  onPressed: () {
                                    // TODO: Implement audio playback
                                  },
                                ),
                              ],
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
                              buttonColor: buttonColor,
                              icon: Icons.arrow_back_ios_new,
                              onPressed: () => cycleNotifier.previousStage(),
                            )
                          else
                            const SizedBox(width: 56),
                          
                          // Next button or Complete button
                          if (currentStageIndex < stages.length - 1)
                            CustomButton(
                              height: 56,
                              width: 56,
                              cornerRadius: 12,
                              buttonColor: buttonColor,
                              icon: Icons.arrow_forward_ios,
                              onPressed: () => cycleNotifier.nextStage(),
                            )
                          else
                            CustomButton(
                              height: 56,
                              width: 120,
                              cornerRadius: 12,
                              buttonColor: buttonColor,
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
      ),
    );
  }
} 