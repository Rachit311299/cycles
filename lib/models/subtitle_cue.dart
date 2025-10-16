class SubtitleCue {
  final int index;
  final Duration startTime;
  final Duration endTime;
  final String text;

  const SubtitleCue({
    required this.index,
    required this.startTime,
    required this.endTime,
    required this.text,
  });

  bool isActiveAt(Duration position) {
    return position >= startTime && position < endTime;
  }

  @override
  String toString() {
    return 'SubtitleCue($index: ${startTime.inMilliseconds}ms-${endTime.inMilliseconds}ms: "$text")';
  }
}
