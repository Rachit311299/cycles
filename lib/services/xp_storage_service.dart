import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/xp_data.dart';

/// Service for managing XP data persistence using SharedPreferences
class XPStorageService {
  static const String _xpDataKey = 'xp_data';
  static const String _backupKey = 'xp_data_backup';

  /// Save XP data to local storage
  Future<void> saveXPData(XPData xpData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(xpData.toJson());
      
      // Create backup before saving
      await _createBackup(prefs);
      
      // Save new data
      await prefs.setString(_xpDataKey, jsonString);
    } catch (e) {
      throw XPStorageException('Failed to save XP data: $e');
    }
  }

  /// Load XP data from local storage
  Future<XPData> loadXPData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_xpDataKey);
      
      if (jsonString == null) {
        // Return initial data if no saved data exists
        return XPData.initial();
      }
      
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      return XPData.fromJson(jsonData);
    } catch (e) {
      // If loading fails, try to restore from backup
      try {
        return await _restoreFromBackup();
      } catch (backupError) {
        // If backup also fails, return initial data
        return XPData.initial();
      }
    }
  }

  /// Create a backup of current XP data
  Future<void> _createBackup(SharedPreferences prefs) async {
    try {
      final currentData = prefs.getString(_xpDataKey);
      if (currentData != null) {
        await prefs.setString(_backupKey, currentData);
      }
    } catch (e) {
      // Backup creation failure shouldn't prevent main save
      print('Warning: Failed to create XP data backup: $e');
    }
  }

  /// Restore XP data from backup
  Future<XPData> _restoreFromBackup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final backupString = prefs.getString(_backupKey);
      
      if (backupString == null) {
        throw XPStorageException('No backup data available');
      }
      
      final jsonData = jsonDecode(backupString) as Map<String, dynamic>;
      return XPData.fromJson(jsonData);
    } catch (e) {
      throw XPStorageException('Failed to restore from backup: $e');
    }
  }

  /// Reset all XP data (useful for testing or user reset)
  Future<void> resetXPData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_xpDataKey);
      await prefs.remove(_backupKey);
    } catch (e) {
      throw XPStorageException('Failed to reset XP data: $e');
    }
  }

  /// Export XP data as JSON string (for backup/transfer)
  Future<String> exportXPData() async {
    try {
      final xpData = await loadXPData();
      return jsonEncode(xpData.toJson());
    } catch (e) {
      throw XPStorageException('Failed to export XP data: $e');
    }
  }

  /// Import XP data from JSON string (for restore/transfer)
  Future<void> importXPData(String jsonString) async {
    try {
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      final xpData = XPData.fromJson(jsonData);
      await saveXPData(xpData);
    } catch (e) {
      throw XPStorageException('Failed to import XP data: $e');
    }
  }

  /// Check if XP data exists in storage
  Future<bool> hasXPData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_xpDataKey);
    } catch (e) {
      return false;
    }
  }

  /// Get storage statistics
  Future<Map<String, dynamic>> getStorageStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasData = prefs.containsKey(_xpDataKey);
      final hasBackup = prefs.containsKey(_backupKey);
      
      return {
        'hasData': hasData,
        'hasBackup': hasBackup,
        'storageKeys': prefs.getKeys().where((key) => key.startsWith('xp_')).toList(),
      };
    } catch (e) {
      return {
        'hasData': false,
        'hasBackup': false,
        'error': e.toString(),
      };
    }
  }
}

/// Custom exception for XP storage operations
class XPStorageException implements Exception {
  final String message;
  
  const XPStorageException(this.message);
  
  @override
  String toString() => 'XPStorageException: $message';
}
