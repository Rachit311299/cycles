import 'package:cycles/widgets/custom_button.dart';
import 'package:cycles/widgets/custom_profile_button.dart';
import 'package:cycles/widgets/cycle_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _showTranslateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                'Language',
                style: TextStyle(
                  fontFamily: 'PoetsenOne',
                  fontSize: 36,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              height: 60,
                              width: double.infinity,
                              cornerRadius: 12,
                              buttonColor: const Color(0xFF4B70EA),
                              text: 'English',
                              onPressed: () {
                                // Handle language selection
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              height: 60,
                              width: double.infinity,
                              cornerRadius: 12,
                              buttonColor: const Color(0xFF4B70EA),
                              text: 'French',
                              onPressed: () {
                                // Handle language selection
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              height: 60,
                              width: double.infinity,
                              cornerRadius: 12,
                              buttonColor: const Color(0xFF4B70EA),
                              text: 'Spanish',
                              onPressed: () {
                                // Handle language selection
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              height: 60,
                              width: double.infinity,
                              cornerRadius: 12,
                              buttonColor: const Color(0xFF4B70EA),
                              text: 'Hindi',
                              onPressed: () {
                                // Handle language selection
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top row of buttons (fixed)
            Padding(
              padding: const EdgeInsets.only(left: 34, right: 34, top: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Translate Button
                  CustomButton(
                    height: 50,
                    width: 50,
                    cornerRadius: 18,
                    buttonColor: const Color(0xFF8089FF),
                    icon: Icons.g_translate,
                    onPressed: () {
                      _showTranslateBottomSheet(context);
                    },
                  ),
                  // Profile Button (center)
                  ProfileButton(
                    imageUrl:
                        'https://img.freepik.com/free-vector/flat-style-woman-avatar_90220-2876.jpg',
                    xpProgress: 0.3, // 30% XP progress
                    level: 5,        // Example level
                  ),
                  // Settings Button
                  CustomButton(
                    height: 50,
                    width: 50,
                    cornerRadius: 18,
                    buttonColor: const Color(0xFF93D253),
                    icon: Icons.settings,
                    onPressed: () {
                      context.push('/settings');
                    },
                  ),
                ],
              ),
            ),

            // Greeting text + cards scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 34, right: 34, top: 25, bottom: 10),
                      child: Row(
                        children:  [
                          Expanded(
                            child: Text(
                              'Hi John, Ready to Learn !!!',
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: "PoetsenOne",
                                color:Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Cards
                    CycleCard(
                      title: 'Plant Cycle',
                      backgroundImage: 'assets/images/plant_cycle.jpg',
                      textColor: const Color(0xFFF8FD78),
                      onTap: () => context.push('/plant-cycle'),
                    ),
                    CycleCard(
                      title: 'Water Cycle',
                      backgroundImage: 'assets/images/water_cycle.jpg',
                      textColor: const Color(0xFFD7EEFC),
                      onTap: () => context.push('/water-cycle'),
                    ),
                    CycleCard(
                      title: 'Rock Cycle',
                      backgroundImage: 'assets/images/rock_cycle.jpg',
                      textColor: const Color(0xFFF7DB6A),
                      onTap: () => context.push('/rock-cycle'),
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
}