import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_button.dart'; // Ensure this file contains the CustomButton widget

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                  Text(
                    'Settings',
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
            Divider(
              thickness: 1,
              height: 1,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge?.color?.withOpacity(0.10),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0, right: 10),
              child: _buildSettingItem(
                'Dark Theme',
                Switch(value: false, onChanged: (value) {}),
              ),
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge?.color?.withOpacity(0.10),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0, right: 10),
              child: _buildSettingItem(
                'Volume',
                Slider(
                  value: 0.5,
                  onChanged: (value) {},
                  activeColor: Colors.blue,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge?.color?.withOpacity(0.10),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0, right: 10),
              child: _buildSettingItem(
                'Questions?',
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'FAQ',
                    style: TextStyle(fontFamily: 'PoetsenOne'),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge?.color?.withOpacity(0.10),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0, right: 10),
              child: _buildSettingItem(
                'Report a bug',
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Email',
                    style: TextStyle(fontFamily: 'PoetsenOne'),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge?.color?.withOpacity(0.10),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomButton(
                height: 50,
                width: 200,
                cornerRadius: 12,
                buttonColor: const Color(0xFFD23B3B),
                text: 'Logout',
                onPressed: () {
                  debugPrint('Logout button pressed');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, Widget trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontFamily: 'PoetsenOne')),
          trailing,
        ],
      ),
    );
  }
}
