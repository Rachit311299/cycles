import 'dart:async';
import 'package:flutter/services.dart';
import '../models/subtitle_cue.dart';

class SrtParser {
  static Future<List<SubtitleCue>> parseFromAsset(String assetPath) async {
    try {
      final String content = await rootBundle.loadString(assetPath);
      return _parseContent(content);
    } catch (e) {
      throw Exception('Failed to load SRT file from $assetPath: $e');
    }
  }

  static List<SubtitleCue> _parseContent(String content) {
    final List<SubtitleCue> cues = [];
    final List<String> blocks = content.split('\n\n');
    
    for (final String block in blocks) {
      if (block.trim().isEmpty) continue;
      
      final List<String> lines = block.trim().split('\n');
      if (lines.length < 3) continue;
      
      try {
        // Parse index
        final int index = int.parse(lines[0].trim());
        
        // Parse timing (format: 00:00:00,000 --> 00:00:00,000)
        final String timingLine = lines[1].trim();
        final List<String> times = timingLine.split(' --> ');
        if (times.length != 2) continue;
        
        final Duration startTime = _parseTimeString(times[0].trim());
        final Duration endTime = _parseTimeString(times[1].trim());
        
        // Parse text (remaining lines)
        final String text = lines.skip(2).join('\n').trim();
        
        cues.add(SubtitleCue(
          index: index,
          startTime: startTime,
          endTime: endTime,
          text: text,
        ));
      } catch (e) {
        // Skip malformed blocks
        continue;
      }
    }
    
    return cues;
  }

  static Duration _parseTimeString(String timeStr) {
    // Format: HH:MM:SS,mmm
    final List<String> parts = timeStr.split(':');
    if (parts.length != 3) throw FormatException('Invalid time format: $timeStr');
    
    final int hours = int.parse(parts[0]);
    final int minutes = int.parse(parts[1]);
    final List<String> secondsAndMs = parts[2].split(',');
    final int seconds = int.parse(secondsAndMs[0]);
    final int milliseconds = int.parse(secondsAndMs[1]);
    
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }
}
