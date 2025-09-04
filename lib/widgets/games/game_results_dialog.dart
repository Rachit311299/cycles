import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../custom_button.dart';  // Go up one level to widgets folder 

class GameResultsDialog extends StatelessWidget {
  final double score;
  final int correct;
  final int total;
  final Color themeColor;
  final VoidCallback onTryAgain;
  final String gameType;
  final int xpEarned;
  final bool isFirstTime;

  const GameResultsDialog({
    super.key,
    required this.score,
    required this.correct,
    required this.total,
    required this.themeColor,
    required this.onTryAgain,
    required this.gameType,
    required this.xpEarned,
    required this.isFirstTime,
  });

  String _getResultMessage(double percentage) {
    if (percentage >= 0.9) return 'Excellent! You\'re a cycle expert! 🌟';
    if (percentage >= 0.7) return 'Great job! Keep learning! 👏';
    if (percentage >= 0.5) return 'Good effort! Try again to improve! 💪';
    return 'Keep practicing to learn more! 📚';
  }

  @override
  Widget build(BuildContext context) {
    final isHighScore = score >= 0.7;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isHighScore ? Icons.emoji_events : Icons.school,
                    size: 50,
                    color: themeColor,
                  ),
                ),
                if (isHighScore)
                  Positioned(
                    right: -10,
                    top: -10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: score),
              builder: (context, double value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: value,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          score >= 0.7 ? Colors.green : themeColor,
                        ),
                        strokeWidth: 8,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '${(value * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'PoetsenOne',
                            color: score >= 0.7 ? Colors.green : themeColor,
                          ),
                        ),
                        Text(
                          '$correct/$total',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            
            Text(
              '$gameType Complete!',
              style: const TextStyle(
                fontSize: 28,
                fontFamily: 'PoetsenOne',
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            Text(
              _getResultMessage(score),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // XP Earned Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.amber.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber.shade700,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+$xpEarned XP',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'PoetsenOne',
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isFirstTime) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'FIRST TIME!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 48,
                    width: double.infinity,
                    cornerRadius: 12,
                    buttonColor: Colors.grey.shade200,
                    onPressed: () {
                      context.pop(); // Close dialog
                      if (gameType == 'Cycle Builder') {
                        // For builder games, just close the dialog, don't exit the game
                        // This allows users to see their mistakes and try again
                      } else {
                        // For trivia games, exit to games menu
                        context.pop(); // Return to games menu
                      }
                    },
                    child: Text(
                      gameType == 'Cycle Builder' ? 'Close' : 'Exit',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (score >= 1.0) ...[
                  // Only show "Try Again" for perfect scores
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      height: 48,
                      width: double.infinity,
                      cornerRadius: 12,
                      buttonColor: themeColor,
                      onPressed: () {
                        context.pop(); // Close dialog
                        onTryAgain();
                      },
                      child: const Text(
                        'Try Again',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
} 