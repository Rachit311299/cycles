import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/xp_data.dart';
import '../providers/xp_provider.dart';
import 'custom_button.dart';

/// Dialog shown when user unlocks an achievement
class AchievementDialog extends ConsumerStatefulWidget {
  final Achievement achievement;
  final VoidCallback? onClose;

  const AchievementDialog({
    super.key,
    required this.achievement,
    this.onClose,
  });

  @override
  ConsumerState<AchievementDialog> createState() => _AchievementDialogState();
}

class _AchievementDialogState extends ConsumerState<AchievementDialog>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _glowController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
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

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _scaleController.forward();
    _rotationController.forward();
    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated achievement icon
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glow effect
                      AnimatedBuilder(
                        animation: _glowAnimation,
                        builder: (context, child) {
                          return Container(
                            width: 120 + (20 * _glowAnimation.value),
                            height: 120 + (20 * _glowAnimation.value),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  widget.achievement.color.withOpacity(0.3 * _glowAnimation.value),
                                  widget.achievement.color.withOpacity(0.1 * _glowAnimation.value),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // Main achievement icon
                      AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationAnimation.value * 0.1,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: widget.achievement.color.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: widget.achievement.color,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.achievement.color.withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                _getAchievementIcon(widget.achievement.iconName),
                                size: 50,
                                color: widget.achievement.color,
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
            
            // Achievement unlocked text
            Text(
              'ACHIEVEMENT UNLOCKED!',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'PoetsenOne',
                color: widget.achievement.color,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Achievement title
            Text(
              widget.achievement.title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'PoetsenOne',
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            // Achievement description
            Text(
              widget.achievement.description,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            // Achievement benefits
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.achievement.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: widget.achievement.color,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This achievement is now permanently unlocked in your profile!',
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.achievement.color,
                        fontFamily: 'PoetsenOne',
                      ),
                    ),
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
              buttonColor: widget.achievement.color,
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

  IconData _getAchievementIcon(String iconName) {
    switch (iconName) {
      case 'star': return Icons.star;
      case 'construction': return Icons.construction;
      case 'school': return Icons.school;
      case 'emoji_events': return Icons.emoji_events;
      case 'all_inclusive': return Icons.all_inclusive;
      case 'military_tech': return Icons.military_tech;
      default: return Icons.emoji_events;
    }
  }
}

/// Widget to display all achievements in a list
class AchievementsListWidget extends ConsumerWidget {
  const AchievementsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievements = ref.read(xpDataProvider.notifier).getAllAchievements();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'PoetsenOne',
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...achievements.map((achievement) => _buildAchievementCard(context, achievement)),
      ],
    );
  }

  Widget _buildAchievementCard(BuildContext context, Achievement achievement) {
    final isUnlocked = achievement.isUnlocked;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked 
            ? achievement.color.withOpacity(0.1)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked 
              ? achievement.color.withOpacity(0.3)
              : Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Achievement icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isUnlocked 
                  ? achievement.color.withOpacity(0.2)
                  : Theme.of(context).cardColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isUnlocked 
                    ? achievement.color.withRed((achievement.color.red * 0.6).round())
                        .withGreen((achievement.color.green * 0.6).round())
                        .withBlue((achievement.color.blue * 0.6).round())
                    : Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Icon(
              _getAchievementIcon(achievement.iconName),
              color: isUnlocked 
                  ? achievement.color.withRed((achievement.color.red * 0.6).round())
                      .withGreen((achievement.color.green * 0.6).round())
                      .withBlue((achievement.color.blue * 0.6).round())
                  : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Achievement info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'PoetsenOne',
                    color: isUnlocked 
                        ? Theme.of(context).textTheme.bodyLarge?.color
                        : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isUnlocked 
                        ? Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7)
                        : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
                    height: 1.3,
                  ),
                ),
                if (isUnlocked && achievement.unlockedAt != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Unlocked: ${_formatDate(achievement.unlockedAt!)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: achievement.color.withRed((achievement.color.red * 0.6).round())
                          .withGreen((achievement.color.green * 0.6).round())
                          .withBlue((achievement.color.blue * 0.6).round()),
                      fontFamily: 'PoetsenOne',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Lock/unlock indicator
          Icon(
            isUnlocked ? Icons.check_circle : Icons.lock,
            color: isUnlocked 
                ? Colors.green 
                : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
            size: 24,
          ),
        ],
      ),
    );
  }

  IconData _getAchievementIcon(String iconName) {
    switch (iconName) {
      case 'star': return Icons.star;
      case 'construction': return Icons.construction;
      case 'school': return Icons.school;
      case 'emoji_events': return Icons.emoji_events;
      case 'all_inclusive': return Icons.all_inclusive;
      case 'military_tech': return Icons.military_tech;
      default: return Icons.emoji_events;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
