import 'package:flutter/material.dart';

//usage of custom button
// CustomButton(
//           height: 60,
//           width: 200,
//           cornerRadius: 12,
//           buttonColor: Colors.blue,
//           text: 'Click Me',
//           onPressed: () {
//             debugPrint('3D Button Pressed!');
//           },
//         )

class CustomButton extends StatefulWidget {
  /// Required parameters
  final double height;
  final double width;
  final double cornerRadius;
  final Color buttonColor;

  /// Optional parameters
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.cornerRadius,
    required this.buttonColor,
    this.text,
    this.icon,
    this.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  static const Duration _animationDuration = Duration(milliseconds: 80);
  static const double _defaultElevation = 4.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

void _onTapUp(TapUpDetails details) {
  // Wait briefly so the pressed-down animation is visible
  Future.delayed(_animationDuration, () {
    if (mounted) {
      _controller.reverse();
    }
  });
  
  // Fire onPressed
  widget.onPressed?.call();
}

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    // The total widget height includes the top layer plus the elevation.
    final totalHeight = widget.height + _defaultElevation;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Offset the top layer downward by some fraction of _defaultElevation
          final offset = _controller.value * _defaultElevation;

          // Darken the bottom layer color to create a “shadow” effect
          final bottomColor = _darkenColor(widget.buttonColor, 0.15);

          return SizedBox(
            height: totalHeight,
            width: widget.width,
            child: Stack(
              children: [
                // Bottom layer (shadow or “3D” base)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      color: bottomColor,
                      borderRadius: BorderRadius.circular(widget.cornerRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 2),
                          blurRadius: 1.8,
                          spreadRadius: 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
                // Top layer (actual button)
                Positioned(
                  top: offset,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      color: widget.buttonColor,
                      borderRadius: BorderRadius.circular(widget.cornerRadius),
                    ),
                    alignment: Alignment.center,
                    child: _buildButtonContent(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the button content based on text + icon presence.
  Widget _buildButtonContent() {
    // If both text and icon are provided, arrange them horizontally
    if (widget.text != null && widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            widget.text!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'PoetsenOne',
            ),
          ),
        ],
      );
    }
    // If only icon
    else if (widget.icon != null) {
      return Icon(widget.icon, color: Colors.white);
    }
    // If only text
    else if (widget.text != null) {
      return Text(
        widget.text!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'PoetsenOne',
        ),
      );
    }
    // No icon/text
    return const SizedBox.shrink();
  }

  /// Simple helper to darken the original button color
  Color _darkenColor(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final darker = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darker.toColor();
  }
}
