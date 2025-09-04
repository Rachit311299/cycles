import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/xp_provider.dart';

/// Widget to display current XP, level, and progress
class XPDisplayWidget extends ConsumerWidget {
  final bool showProgressBar;
  final bool showLevelName;
  final double? width;
  final double? height;

  const XPDisplayWidget({
    super.key,
    this.showProgressBar = true,
    this.showLevelName = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xpData = ref.watch(xpDataProvider);

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: xpData.levelColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: xpData.levelColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Level and XP info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: xpData.levelColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Level ${xpData.currentLevel}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'PoetsenOne',
                      color: xpData.levelColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (showLevelName) ...[
                    const SizedBox(width: 8),
                    Text(
                      '(${xpData.levelName})',
                      style: TextStyle(
                        fontSize: 14,
                        color: xpData.levelColor.withOpacity(0.8),
                        fontFamily: 'PoetsenOne',
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                '${xpData.totalXP} XP',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'PoetsenOne',
                  color: xpData.levelColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          if (showProgressBar && xpData.currentLevel < 5) ...[
            const SizedBox(height: 8),
            // Progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress to Level ${xpData.currentLevel + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        color: xpData.levelColor.withOpacity(0.8),
                        fontFamily: 'PoetsenOne',
                      ),
                    ),
                    Text(
                      '${xpData.xpInCurrentLevel}/${xpData.xpRequiredForCurrentLevel}',
                      style: TextStyle(
                        fontSize: 12,
                        color: xpData.levelColor.withOpacity(0.8),
                        fontFamily: 'PoetsenOne',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: xpData.xpInCurrentLevel / xpData.xpRequiredForCurrentLevel,
                    backgroundColor: xpData.levelColor.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(xpData.levelColor),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Compact XP display for headers/toolbars
class CompactXPDisplay extends ConsumerWidget {
  const CompactXPDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xpData = ref.watch(xpDataProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: xpData.levelColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: xpData.levelColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: xpData.levelColor,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            'L${xpData.currentLevel} • ${xpData.totalXP} XP',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'PoetsenOne',
              color: xpData.levelColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// XP progress indicator for showing XP gained
class XPProgressIndicator extends StatefulWidget {
  final int xpGained;
  final Color color;
  final Duration duration;

  const XPProgressIndicator({
    super.key,
    required this.xpGained,
    required this.color,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<XPProgressIndicator> createState() => _XPProgressIndicatorState();
}

class _XPProgressIndicatorState extends State<XPProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+${widget.xpGained} XP',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'PoetsenOne',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
