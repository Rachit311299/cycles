class CycleStage {
  final String name;
  final String description;
  final String imageAsset;
  final Map<String, String> translations;
  final Map<String, String>? audioAssets;
  final String? explanationAudio;

  CycleStage({
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.translations,
    this.audioAssets,
    this.explanationAudio,
  });
}