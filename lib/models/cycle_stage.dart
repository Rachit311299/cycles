class CycleStage {
  final String name;
  final String description;
  final String imageAsset;
  final Map<String, String> translations;
  final Map<String, String>? audioAssets;
  final Map<String, String>? explanationAudioAssets;
  final String? explanationAudio;
  final String? explanationSubtitles;
  final String? animationAsset;

  CycleStage({
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.translations,
    this.audioAssets,
    this.explanationAudioAssets,
    this.explanationAudio,
    this.explanationSubtitles,
    this.animationAsset,
  });
}