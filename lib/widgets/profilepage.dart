import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

            // Profile card with avatar and user info
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
                  // User info
                  Column(
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
                    ],
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