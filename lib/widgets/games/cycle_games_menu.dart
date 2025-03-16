import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../custom_button.dart';
import './game_option.dart';

class CycleGamesMenu extends StatelessWidget {
  final String cycleTitle;
  final Color backgroundColor;
  final Color buttonColor;
  final List<GameOption> games;

  const CycleGamesMenu({
    super.key,
    required this.cycleTitle,
    required this.backgroundColor,
    required this.buttonColor,
    required this.games,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      '$cycleTitle Games',
                      style: const TextStyle(
                        fontSize: 28,
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
            const Text(
              'Choose a game to play',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontFamily: 'PoetsenOne',
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: games.length,
                itemBuilder: (context, index) {
                  final game = games[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CustomButton(
                      height: 200,
                      width: double.infinity,
                      cornerRadius: 20,
                      buttonColor: buttonColor,
                      onPressed: () => context.push(game.route),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 20,
                            top: 20,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                game.icon,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 24,
                            bottom: 24,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  game.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontFamily: 'PoetsenOne',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  game.description,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
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
      ),
    );
  }
} 