import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cycles/providers/theme_notifier.dart';
import 'package:cycles/providers/volume_provider.dart';
import 'custom_button.dart';

class SettingsPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  double? _previousVolume; // Store previous volume before muting

  @override
  Widget build(BuildContext context) {
    // Watch the current theme mode to reflect it in the UI
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    
    // Watch the current volume
    final volume = ref.watch(volumeProvider);

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
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    // Toggle theme using the theme notifier
                    ref.read(themeModeProvider.notifier).toggleTheme(value);
                  },
                  activeColor: const Color(0xFF93D253),
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
              child: _buildVolumeSetting(context, ref, volume),
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

  Widget _buildVolumeSetting(BuildContext context, WidgetRef ref, double volume) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Volume',
            style: TextStyle(fontSize: 18, fontFamily: 'PoetsenOne'),
          ),
          Row(
            children: [
              // Volume icon - fixed width with tap functionality
              SizedBox(
                width: 24,
                child: GestureDetector(
                  onTap: () {
                    _toggleMute(ref, volume);
                  },
                  child: Icon(
                    _getVolumeIcon(volume),
                    color: const Color(0xFF93D253),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Compact slider - fixed width
              SizedBox(
                width: 120,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFF93D253),
                    inactiveTrackColor: Colors.grey.shade300,
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                    trackHeight: 4,
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                  ),
                  child: Slider(
                    value: volume,
                    onChanged: (value) {
                      ref.read(volumeProvider.notifier).setVolume(value);
                    },
                    min: 0.0,
                    max: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Volume percentage - fixed width
              SizedBox(
                width: 40,
                child: Text(
                  '${(volume * 100).round()}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'PoetsenOne',
                    color: const Color(0xFF93D253),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleMute(WidgetRef ref, double currentVolume) {
    if (currentVolume == 0) {
      // Currently muted, restore previous volume or default to 50%
      final volumeToRestore = _previousVolume ?? 0.5;
      ref.read(volumeProvider.notifier).setVolume(volumeToRestore);
    } else {
      // Currently not muted, save current volume and mute
      _previousVolume = currentVolume;
      ref.read(volumeProvider.notifier).setVolume(0.0);
    }
  }

  IconData _getVolumeIcon(double volume) {
    if (volume == 0) {
      return Icons.volume_off;
    } else if (volume < 0.5) {
      return Icons.volume_down;
    } else {
      return Icons.volume_up;
    }
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