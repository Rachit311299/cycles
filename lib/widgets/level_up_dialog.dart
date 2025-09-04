import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/xp_provider.dart';
import 'custom_button.dart';

/// Dialog shown when user levels up
class LevelUpDialog extends ConsumerStatefulWidget {
  final int newLevel;
  final VoidCallback? onClose;

  const LevelUpDialog({
    super.key,
    required this.newLevel,
    this.onClose,
  });

  @override
  ConsumerState<LevelUpDialog> createState() => _LevelUpDialogState();
}

class _LevelUpDialogState extends ConsumerState<LevelUpDialog>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _sparkleController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _sparkleAnimation;

  @override
  void initState() {
    super.initState();
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _sparkleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    _sparkleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _sparkleController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _scaleController.forward();
    _rotationController.forward();
    _sparkleController.repeat();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final xpData = ref.watch(xpDataProvider);
    final levelColor = xpData.levelColor;
    final levelName = xpData.levelName;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated level up icon
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Sparkle effects
                      AnimatedBuilder(
                        animation: _sparkleAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            size: const Size(120, 120),
                            painter: SparklePainter(
                              animation: _sparkleAnimation.value,
                              color: levelColor,
                            ),
                          );
                        },
                      ),
                      // Main icon
                      AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationAnimation.value * 0.1,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: levelColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: levelColor,
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                _getLevelIcon(widget.newLevel),
                                size: 50,
                                color: levelColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Level up text
            Text(
              'LEVEL UP!',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'PoetsenOne',
                color: levelColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'You reached Level ${widget.newLevel}',
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'PoetsenOne',
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 4),
            
            Text(
              levelName,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'PoetsenOne',
                color: levelColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Level benefits
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: levelColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Level Benefits',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'PoetsenOne',
                      color: levelColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getLevelBenefits(widget.newLevel),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Close button
            CustomButton(
              height: 48,
              width: double.infinity,
              cornerRadius: 12,
              buttonColor: levelColor,
              onPressed: () {
                Navigator.of(context).pop();
                widget.onClose?.call();
              },
              child: const Text(
                'Awesome!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PoetsenOne',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getLevelIcon(int level) {
    switch (level) {
      case 1: return Icons.school;
      case 2: return Icons.explore;
      case 3: return Icons.menu_book;
      case 4: return Icons.psychology;
      case 5: return Icons.military_tech;
      default: return Icons.star;
    }
  }

  String _getLevelBenefits(int level) {
    switch (level) {
      case 1: return 'Welcome to your learning journey! Keep playing to unlock more achievements.';
      case 2: return 'You\'re becoming an explorer! Unlock new achievements and track your progress.';
      case 3: return 'You\'re a true scholar! Your dedication to learning is impressive.';
      case 4: return 'You\'re an expert! Your knowledge of cycles is remarkable.';
      case 5: return 'You\'re a master! You\'ve reached the highest level of cycle knowledge.';
      default: return 'Keep learning and exploring!';
    }
  }
}

/// Custom painter for sparkle effects
class SparklePainter extends CustomPainter {
  final double animation;
  final Color color;

  SparklePainter({
    required this.animation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw sparkles around the circle
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45.0) * (3.14159 / 180.0);
      final sparkleRadius = radius * 0.8;
      final x = center.dx + sparkleRadius * math.cos(angle);
      final y = center.dy + sparkleRadius * math.sin(angle);
      
      final sparkleSize = 4.0 * (1.0 + math.sin(animation * 2 * 3.14159 + i));
      
      canvas.drawCircle(
        Offset(x, y),
        sparkleSize,
        paint..color = color.withOpacity(0.4 * (1.0 + math.sin(animation * 2 * 3.14159 + i))),
      );
    }
  }

  @override
  bool shouldRepaint(SparklePainter oldDelegate) {
    return oldDelegate.animation != animation || oldDelegate.color != color;
  }
}


