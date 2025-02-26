import 'package:flutter/material.dart';

class CycleCard extends StatefulWidget {
  final String title;
  final String backgroundImage; // Asset or Network path
  final Color textColor;
  final VoidCallback? onTap; // Optional: if you want the card to be tappable

  const CycleCard({
    Key? key,
    required this.title,
    required this.backgroundImage,
    required this.textColor,
    this.onTap,
  }) : super(key: key);

  @override
  State<CycleCard> createState() => _CycleCardState();
}

class _CycleCardState extends State<CycleCard>
    with SingleTickerProviderStateMixin {
  static const Duration _animationDuration = Duration(milliseconds: 80);
  static const double _defaultElevation = 6.0;
  static const double _cardHeight = 200.0;

  late final AnimationController _controller;

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
    _controller.forward(); // Press down
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(_animationDuration, () {
      _controller.reverse();
    });
    widget.onTap?.call(); 
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = _cardHeight + _defaultElevation;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final offset = _controller.value * _defaultElevation;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            height: totalHeight,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: _cardHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: AssetImage(widget.backgroundImage),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.darken,
                        ),
                      ),
                      // Add a shadow for extra depth
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

                // Top layer (actual card content) that moves down on press
                Positioned(
                  top: offset,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: _cardHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: AssetImage(widget.backgroundImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        // Centered text
                        Center(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              color: widget.textColor,
                              fontSize: 54,
                              fontFamily: 'PoetsenOne',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
