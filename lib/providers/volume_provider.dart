import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolumeNotifier extends StateNotifier<double> {
  VolumeNotifier() : super(0.5) {
    _loadVolume();
  }

  static const String _volumeKey = 'app_volume';

  void setVolume(double volume) {
    state = volume.clamp(0.0, 1.0);
    _saveVolume();
  }

  Future<void> _loadVolume() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedVolume = prefs.getDouble(_volumeKey);
      if (savedVolume != null) {
        state = savedVolume;
      }
    } catch (e) {
      // If loading fails, keep default value
      state = 0.5;
    }
  }

  Future<void> _saveVolume() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_volumeKey, state);
    } catch (e) {
      // If saving fails, continue silently
    }
  }
}

final volumeProvider = StateNotifierProvider<VolumeNotifier, double>((ref) {
  return VolumeNotifier();
});
