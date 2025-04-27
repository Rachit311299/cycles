import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cycle_stage.dart';

class CycleNotifier extends StateNotifier<int> {
  final List<CycleStage> stages;
  
  CycleNotifier({required this.stages}) : super(0);

  void nextStage() {
    if (state < stages.length - 1) {
      state = state + 1;
    }
  }

  void previousStage() {
    if (state > 0) {
      state = state - 1;
    }
  }

  void reset() {
    state = 0;
  }
}

final plantCycleProvider = StateNotifierProvider<CycleNotifier, int>((ref) {
  return CycleNotifier(stages: plantCycleStages);
});

final waterCycleProvider = StateNotifierProvider<CycleNotifier, int>((ref) {
  return CycleNotifier(stages: waterCycleStages);
});

final rockCycleProvider = StateNotifierProvider<CycleNotifier, int>((ref) {
  return CycleNotifier(stages: rockCycleStages);
});

// Define stages for each cycle
final List<CycleStage> plantCycleStages = [
  CycleStage(
    name: 'Seeds',
    description: 'Seeds contain everything needed to create a new plant.',
    imageAsset: 'assets/images/plant_cycle/seeds.png',
    translations: {
      'es': 'Semillas',
      'fr': 'Graines',
      'hi': 'बीज',
    },
    audioAssets: {
      'en': 'aasets/audio/plant_cycle/en/Pro-Seeds.mp3',
      'es': 'aasets/audio/plant_cycle/es/Pro-Semilias.mp3',
    },
    explanationAudio: 'assets/audio/plant_cycle/stages/PCEX-S1-Seeds.mp3',
  ),
  CycleStage(
    name: 'Germination',
    description: 'The seed absorbs water and begins to sprout, developing its first root and shoot.',
    imageAsset: 'assets/images/plant_cycle/germination.png',
    translations: {
      'es': 'Germinación',
      'fr': 'Germination',
      'hi': 'अंकुरण',
    },
    audioAssets: {
      'en': 'aasets/audio/plant_cycle/en/Pro-Germination.mp3',
      'es': 'aasets/audio/plant_cycle/es/Pro-Germinacion.mp3',
    },
    explanationAudio: 'assets/audio/plant_cycle/stages/PCEX-S2-Germination.mp3',
  ),
  CycleStage(
    name: 'Seedling',
    description: 'The young plant emerges from the soil with its first leaves.',
    imageAsset: 'assets/images/plant_cycle/seedling.png',
    translations: {
      'es': 'Plántula',
      'fr': 'Plantule',
      'hi': 'अंकुर',
    },
    audioAssets: {
      'en': 'aasets/audio/plant_cycle/en/Pro-seedling.mp3',
      'es': 'aasets/audio/plant_cycle/es/Pro-plantula.mp3',
    },
    explanationAudio: 'assets/audio/plant_cycle/stages/PCEX-S3-Seedling.mp3',
  ),
  CycleStage(
    name: 'Adult Plant',
    description: 'The plant grows larger, developing more leaves and a strong stem.',
    imageAsset: 'assets/images/plant_cycle/adult_plant.png',
    translations: {
      'es': 'Planta Adulta',
      'fr': 'Plante Adulte',
      'hi': 'वयस्क पौधा',
    },
    audioAssets: {
      'en': 'aasets/audio/plant_cycle/en/Pro-Adultplant.mp3',
      'es': 'aasets/audio/plant_cycle/es/Pro-planatadulta.mp3',
    },
    explanationAudio: 'assets/audio/plant_cycle/stages/PCEX-S4-AdultPlant.mp3',

    
  ),
  CycleStage(
    name: 'Flowering',
    description: 'The plant produces flowers to enable reproduction.',
    imageAsset: 'assets/images/plant_cycle/flowering.png',
    translations: {
      'es': 'Floración',
      'fr': 'Floraison',
      'hi': 'पुष्पण',
    },
    audioAssets: {
      'en': 'aasets/audio/plant_cycle/en/Pro-Flowering.mp3',
      'es': 'aasets/audio/plant_cycle/es/Pro-Floracion.mp3',
    },
    explanationAudio: 'assets/audio/plant_cycle/stages/PCEX-S5-Flowering.mp3',
  ),
];

final List<CycleStage> waterCycleStages = [
  CycleStage(
    name: 'Evaporation',
    description: 'Heat from the sun causes water to turn into water vapor and rise into the air.',
    imageAsset: 'assets/images/water_cycle/evaporation.png',
    translations: {
      'es': 'Evaporación',
      'fr': 'Évaporation',
      'hi': 'वाष्पीकरण',
    },
    audioAssets: {
      'en': 'aasets/audio/water_cycle/en/Pro-Evaporation.mp3',
      'es': 'aasets/audio/water_cycle/es/Pro-Evaporacion.mp3',
    },
    explanationAudio: 'assets/audio/water_cycle/stages/WCEX-S1-Evaporation.mp3',
  ),
  CycleStage(
    name: 'Condensation',
    description: 'Water vapor cools and forms tiny water droplets in clouds.',
    imageAsset: 'assets/images/water_cycle/condensation.png',
    translations: {
      'es': 'Condensación',
      'fr': 'Condensation',
      'hi': 'संघनन',
    },
    audioAssets: {
      'en': 'aasets/audio/water_cycle/en/Pro-Condensation.mp3',
      'es': 'aasets/audio/water_cycle/es/Pro-Condensacion.mp3',
    },
    explanationAudio: 'assets/audio/water_cycle/stages/WCEX-S2-Condensation.mp3',
  ),
  CycleStage(
    name: 'Precipitation',
    description: 'Water falls from clouds as rain, snow, sleet, or hail.',
    imageAsset: 'assets/images/water_cycle/precipitation.png',
    translations: {
      'es': 'Precipitación',
      'fr': 'Précipitation',
      'hi': 'वर्षण',
    },
    audioAssets: {
      'en': 'aasets/audio/water_cycle/en/Pro-Precipitation.mp3',
      'es': 'aasets/audio/water_cycle/es/Pro-Precipitacion.mp3',
    },
    explanationAudio: 'assets/audio/water_cycle/stages/WCEX-S3-Precipitation.mp3',
  ),
    CycleStage(
    name: 'Groundwater flow',
    description: 'Water seeps into the ground and replenishes underground aquifers.',
    imageAsset: 'assets/images/water_cycle/groundwater.png',
    translations: {
      'es': 'Flujo de Agua Subterránea',
      'fr': 'Flux Souterrain',
      'hi': 'भूमिगत जल प्रवाह',
    },
    audioAssets: {
      'en': 'aasets/audio/water_cycle/en/Pro-Groundwater.mp3',
      'es': 'aasets/audio/water_cycle/es/Pro-Fluodeaguasubterranea.mp3',
    },
    explanationAudio: 'assets/audio/water_cycle/stages/WCEX-S4-Groundwater.mp3',
  ),
  CycleStage(
    name: 'Collection',
    description: 'Water collects in bodies of water like oceans, lakes, and rivers.',
    imageAsset: 'assets/images/water_cycle/collection.png',
    translations: {
      'es': 'Acumulación',
      'fr': 'Collection',
      'hi': 'संग्रहण',
    },
    audioAssets: {
      'en': 'aasets/audio/water_cycle/en/Pro-Collection.mp3',
      'es': 'aasets/audio/water_cycle/es/Pro-Acumulacion.mp3',
    },
    explanationAudio: 'assets/audio/water_cycle/stages/WCEX-S5-Collection.mp3',
  ),
];

final List<CycleStage> rockCycleStages = [
  CycleStage(
    name: 'Igneous Rocks',
    description: 'Formed when magma or lava cools and solidifies.',
    imageAsset: 'assets/images/rock_cycle/igneous.png',
    translations: {
      'es': 'Rocas Ígneas',
      'fr': 'Roches Magmatiques',
      'hi': 'आग्नेय चट्टानें',
    },
  ),
  CycleStage(
    name: 'Weathering',
    description: 'Rocks break down into smaller pieces due to weather and erosion.',
    imageAsset: 'assets/images/rock_cycle/weathering.png',
    translations: {
      'es': 'Meteorización',
      'fr': 'Altération',
      'hi': 'अपक्षय',
    },
  ),
  CycleStage(
    name: 'Sediments',
    description: 'Small pieces of rock collect and form layers.',
    imageAsset: 'assets/images/rock_cycle/sediments.png',
    translations: {
      'es': 'Sedimentos',
      'fr': 'Sédiments',
      'hi': 'तलछट',
    },
  ),
  CycleStage(
    name: 'Sedimentary Rocks',
    description: 'Formed when sediments are compressed over time.',
    imageAsset: 'assets/images/rock_cycle/sedimentary.png',
    translations: {
      'es': 'Rocas Sedimentarias',
      'fr': 'Roches Sédimentaires',
      'hi': 'अवसादी चट्टानें',
    },
  ),
  CycleStage(
    name: 'Metamorphic Rocks',
    description: 'Formed when rocks are changed by heat and pressure.',
    imageAsset: 'assets/images/rock_cycle/metamorphic.png',
    translations: {
      'es': 'Rocas Metamórficas',
      'fr': 'Roches Métamorphiques',
      'hi': 'कायांतरित चट्टानें',
    },
  ),
]; 