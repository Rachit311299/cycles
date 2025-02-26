import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String imageUrl;     // URL or local asset path
  final double xpProgress;   // Value from 0.0 to 1.0
  final int level;

  const ProfileButton({
    super.key,
    required this.imageUrl,
    required this.xpProgress,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Circular progress outline
        SizedBox(
          width: 70,
          height: 70,
          child: CircularProgressIndicator(
            value: xpProgress,      // e.g., 0.3 = 30%
            strokeWidth: 4,
            backgroundColor: Theme.of(context).textTheme.bodyLarge?.color,
            valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF8DC4FF)),
            
          ),
          
        ),
        // Profile image
        CircleAvatar(
          radius: 33,
          backgroundImage: NetworkImage(imageUrl),
        ),
        // Level label at bottom
        Positioned(
          bottom: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 1),
            decoration: BoxDecoration(
              color: const Color.fromARGB(208, 50, 50, 50),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              'Lv $level',
              style: const TextStyle(
                color: Color(0xFFF6F6F6),
                fontSize: 13,
                fontFamily: "PoetsenOne",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
