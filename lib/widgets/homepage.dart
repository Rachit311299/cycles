import 'package:cycles/widgets/custom_button.dart';
import 'package:cycles/widgets/custom_profile_button.dart';
import 'package:cycles/widgets/cycle_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:cycles/widgets/cycle_view.dart';
import 'package:cycles/providers/cycle_provider.dart';

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
            color: const Color(0xFFDEDEDE),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                'Language',
                
                style: TextStyle(
                  fontFamily: 'PoetsenOne',
                  
                  fontSize: 36,
                  color: const Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 2.55,
                    children: [
                      CustomButton(
                        height: 60,
                        width: 140,
                        cornerRadius: 12,
                        buttonColor: const Color(0xFF4B70EA),
                        text: 'English',
                        onPressed: () {
                          // Handle language selection
                        },
                      ),
                      CustomButton(
                        height: 60,
                        width: 140,
                        cornerRadius: 12,
                        buttonColor: const Color(0xFF4B70EA),
                        text: 'French',
                        onPressed: () {
                          // Handle language selection
                        },
                      ),
                      CustomButton(
                        height: 60,
                        width: 140,
                        cornerRadius: 12,
                        buttonColor: const Color(0xFF4B70EA),
                        text: 'Spanish',
                        onPressed: () {
                          // Handle language selection
                        },
                      ),
                      CustomButton(
                        height: 60,
                        width: 140,
                        cornerRadius: 12,
                        buttonColor: const Color(0xFF4B70EA),
                        text: 'Hindi',
                        onPressed: () {
                          // Handle language selection
                        },
                      ),
                    ],
                  ),
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
                      // Your settings action
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CycleView(
                              title: 'Plant Cycle',
                              backgroundColor: const Color(0xFFE8F3D6),
                              progressBarColor: const Color(0xFF93D253),
                              imageBackgroundColor: const Color(0xFF93D253),
                              buttonColor: const Color(0xFF93D253),
                              cycleProvider: plantCycleProvider,
                            ),
                          ),
                        );
                      },
                    ),
                    CycleCard(
                      title: 'Water Cycle',
                      backgroundImage: 'assets/images/water_cycle.jpg',
                      textColor: const Color(0xFFD7EEFC),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CycleView(
                              title: 'Water Cycle',
                              backgroundColor: const Color(0xFFE1F5FE),
                              progressBarColor: const Color(0xFF4B70EA),
                              imageBackgroundColor: const Color(0xFF4B70EA),
                              buttonColor: const Color(0xFF4B70EA),
                              cycleProvider: waterCycleProvider,
                            ),
                          ),
                        );
                      },
                    ),
                    CycleCard(
                      title: 'Rock Cycle',
                      backgroundImage: 'assets/images/rock_cycle.jpg',
                      textColor: const Color(0xFFF7DB6A),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CycleView(
                              title: 'Rock Cycle',
                              backgroundColor: const Color(0xFFF5E6CA),
                              progressBarColor: const Color(0xFFF7DB6A),
                              imageBackgroundColor: const Color(0xFFF7DB6A),
                              buttonColor: const Color(0xFFF7DB6A),
                              cycleProvider: rockCycleProvider,
                            ),
                          ),
                        );
                      },
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
