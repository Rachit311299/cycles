import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'custom_button.dart';
import 'xp_display_widget.dart';
import 'achievement_dialog.dart';
import '../providers/xp_provider.dart';
import '../models/xp_data.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xpData = ref.watch(xpDataProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top section with title and back button
            Padding(
              padding: const EdgeInsets.only(
                left: 34,
                right: 34,
                top: 23,
                bottom: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 40, fontFamily: "PoetsenOne"),
                  ),
                  CustomButton(
                    height: 50,
                    width: 50,
                    cornerRadius: 18,
                    buttonColor: const Color(0xFF93D253),
                    icon: Icons.arrow_back,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ),

            // Profile card with avatar, user info, and XP progress in same row
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar with camera icon overlay
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-vector/flat-style-woman-avatar_90220-2876.jpg',
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF93D253),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // User info and XP progress
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'PoetsenOne',
                          ),
                        ),
                        Text(
                          'John_Doe@gmail.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Compact XP Display
                        CompactXPDisplay(),
                        const SizedBox(height: 8),
                        // Mini progress bar
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Progress to Level ${xpData.currentLevel + 1}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                                fontFamily: 'PoetsenOne',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: _calculateProgress(xpData),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: xpData.levelColor,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
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
            ),

            // Stats row - Games and Achievements
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Games Played',
                      '${xpData.gamesPlayed}',
                      Icons.games,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Achievements',
                      '${xpData.unlockedAchievementIds.length}',
                      Icons.emoji_events,
                      const Color(0xFFFF6B35), // Orange color for better visibility
                    ),
                  ),
                ],
              ),
            ),

            // List of profile options
            Expanded(
              child: ListView(
                children: [
                  _buildDivider(context),
                  _buildProfileOption(
                    context,
                    'View Achievements',
                    Icons.emoji_events,
                    () {
                      _showAchievementsDialog(context, ref);
                    },
                  ),
                  _buildDivider(context),
                  _buildProfileOption(
                    context,
                    'Scan code',
                    Icons.qr_code,
                    () {
                      // Handle scan code
                    },
                  ),
                  _buildDivider(context),
                  _buildProfileOption(
                    context,
                    'Notifications',
                    Icons.notifications,
                    () {
                      // Handle notifications
                    },
                  ),
                  _buildDivider(context),
                  _buildProfileOption(
                    context,
                    'Passcode',
                    Icons.lock,
                    () {
                      // Handle passcode
                    },
                  ),
                  _buildDivider(context),
                  _buildProfileOption(
                    context,
                    'Rate our app',
                    Icons.star,
                    () {
                      // Handle rate app
                    },
                  ),
                  _buildDivider(context),
                  _buildProfileOption(
                    context,
                    'Contact us',
                    Icons.email,
                    () {
                      // Handle contact us
                    },
                  ),
                  _buildDivider(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Calculate progress to next level
  double _calculateProgress(XPData xpData) {
    final currentLevelXP = _getXPForLevel(xpData.currentLevel);
    final nextLevelXP = _getXPForLevel(xpData.currentLevel + 1);
    final progressInLevel = (xpData.totalXP - currentLevelXP) / (nextLevelXP - currentLevelXP);
    return progressInLevel.clamp(0.0, 1.0);
  }

  /// Get XP required for a specific level
  int _getXPForLevel(int level) {
    switch (level) {
      case 1: return 0;      // Beginner
      case 2: return 100;    // Explorer
      case 3: return 250;    // Scholar
      case 4: return 500;    // Expert
      case 5: return 1000;   // Master
      default: return 0;
    }
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'PoetsenOne',
              color: color,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.9),
              fontFamily: 'PoetsenOne',
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAchievementsDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: Color(0xFFFF6B35), // Orange color for better visibility
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'PoetsenOne',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: const AchievementsListWidget(),
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                height: 48,
                width: double.infinity,
                cornerRadius: 12,
                buttonColor: const Color(0xFFFF6B35), // Orange color for better visibility
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Close',
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
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      thickness: 1,
      height: 1,
      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.10),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 20.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
            const SizedBox(width: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18, 
                fontFamily: 'PoetsenOne',
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}