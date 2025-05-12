import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cycle_provider.dart';
import '../services/asset_preloader_service.dart';
import './custom_button.dart';

class CycleMenuView extends ConsumerStatefulWidget {
  final String title;
  final Color backgroundColor;
  final Color buttonColor;
  final String cycleType; // 'plant', 'water', or 'rock'

  const CycleMenuView({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.buttonColor,
    required this.cycleType,
  }) : super(key: key);

  @override
  ConsumerState<CycleMenuView> createState() => _CycleMenuViewState();
}

class _CycleMenuViewState extends ConsumerState<CycleMenuView> {
  @override
  void initState() {
    super.initState();
    _triggerPreloading();
  }

  void _triggerPreloading() {
    final cycleProvider = _getCycleProvider();
    if (cycleProvider != null) {
      final stages = ref.read(cycleProvider.notifier).stages;
      AssetPreloaderService().preloadCycleAssets(stages, widget.cycleType);
    }
  }

  StateNotifierProvider<CycleNotifier, int>? _getCycleProvider() {
    switch (widget.cycleType) {
      case 'plant':
        return plantCycleProvider;
      case 'water':
        return waterCycleProvider;
      case 'rock':
        return rockCycleProvider;
      case 'season':
        return seasonCycleProvider;
      default:
        return null;
    }
  }

  @override
  void dispose() {
    AssetPreloaderService().disposeCycleAssets(widget.cycleType);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button and title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => context.go('/'),
                  ),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'PoetsenOne',
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48), // For balance
                ],
              ),
            ),
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMenuButton(
                      context: context,
                      icon: Icons.school,
                      label: 'Learn',
                      description: 'Explore the stages and process',
                      onTap: () => context.push('/${widget.cycleType}-cycle/learn'),
                    ),
                    const SizedBox(height: 20),
                    _buildMenuButton(
                      context: context,
                      icon: Icons.games,
                      label: 'Games',
                      description: 'Fun interactive activities',
                      onTap: () => context.push('/${widget.cycleType}-cycle/games'),
                    ),
                    const SizedBox(height: 20),
                    _buildMenuButton(
                      context: context,
                      icon: Icons.quiz,
                      label: 'Trivia',
                      description: 'Test your knowledge',
                      onTap: () => context.push('/${widget.cycleType}-cycle/trivia'),
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

  Widget _buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: CustomButton(
        height: 100,
        width: double.infinity,
        cornerRadius: 16,
        buttonColor: widget.buttonColor,
        onPressed: onTap,
        child: Row(
          children: [
            const SizedBox(width: 24),
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'PoetsenOne',
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
} 