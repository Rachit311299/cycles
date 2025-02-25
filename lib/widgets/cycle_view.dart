import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cycle_stage.dart';
import '../providers/cycle_provider.dart';
import './homepage.dart';
import './custom_button.dart';

class CycleView extends ConsumerWidget {
  final String title;
  final Color backgroundColor;
  final StateNotifierProvider<CycleNotifier, int> cycleProvider;

  const CycleView({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.cycleProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStageIndex = ref.watch(cycleProvider);
    final cycleNotifier = ref.read(cycleProvider.notifier);
    final currentStage = cycleNotifier.stages[currentStageIndex];
    final progress = (currentStageIndex + 1) / cycleNotifier.stages.length;

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
                    onPressed: () {
                      ref.read(cycleProvider.notifier).reset();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        (route) => false,
                      );
                    },
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF93D253), // Green color for progress
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the close button
                ],
              ),
            ),
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Stage image
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                          child: Image.asset(
                            currentStage.imageAsset,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40), // Increased spacing
                    // Language sections
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
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
                              mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                              children: [
                                Text(
                                  currentStage.name,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'PoetsenOne',
                                    color: Colors.black, // Explicit black color
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
                        const SizedBox(height: 20), // Increased spacing
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
                              mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                              children: [
                                Text(
                                  currentStage.translations['es'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'PoetsenOne',
                                    color: Colors.black, // Explicit black color
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
                              buttonColor: const Color(0xFF93D253),
                              icon: Icons.arrow_back_ios_new,
                              onPressed: () => cycleNotifier.previousStage(),
                            )
                          else
                            const SizedBox(width: 56), // Placeholder for spacing
                          // Next button
                          if (currentStageIndex < cycleNotifier.stages.length - 1)
                            CustomButton(
                              height: 56,
                              width: 56,
                              cornerRadius: 12,
                              buttonColor: const Color(0xFF93D253),
                              icon: Icons.arrow_forward_ios,
                              onPressed: () => cycleNotifier.nextStage(),
                            )
                          else
                            const SizedBox(width: 56), // Placeholder for spacing
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