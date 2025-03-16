import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './custom_button.dart';

class CycleMenuView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
                      title,
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
                      onTap: () => context.push('/$cycleType-cycle/learn'),
                    ),
                    const SizedBox(height: 20),
                    _buildMenuButton(
                      context: context,
                      icon: Icons.games,
                      label: 'Games',
                      description: 'Fun interactive activities',
                      onTap: () => context.push('/$cycleType-cycle/games'),
                    ),
                    const SizedBox(height: 20),
                    _buildMenuButton(
                      context: context,
                      icon: Icons.quiz,
                      label: 'Trivia',
                      description: 'Test your knowledge',
                      onTap: () => context.push('/$cycleType-cycle/trivia'),
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
        buttonColor: buttonColor,
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