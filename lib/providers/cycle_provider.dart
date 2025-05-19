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

final seasonCycleProvider = StateNotifierProvider<CycleNotifier, int>((ref) {
  return CycleNotifier(stages: seasonCycleStages);
});

final butterflyCycleProvider = StateNotifierProvider<CycleNotifier, int>((ref) {
  return CycleNotifier(stages: butterflyCycleStages);
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
    animationAsset: 'assets/animations/plant_cycle/PlantCycle_Stage 1.gif',
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
    animationAsset: 'assets/animations/plant_cycle/PlantCycle_Stage 2.gif',
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
    animationAsset: 'assets/animations/plant_cycle/PlantCycle_Stage 3.gif',
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
    animationAsset: 'assets/animations/plant_cycle/PlantCycle_Stage 4.gif',

    
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
    animationAsset: 'assets/animations/plant_cycle/PlantCycle_Stage 5.gif',
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

final List<CycleStage> seasonCycleStages = [
  CycleStage(
    name: 'Spring',
    description: 'Spring brings new life as plants begin to grow and animals come out of hibernation.',
    imageAsset: 'assets/images/season_cycle/spring.png',
    translations: {
      'es': 'Primavera',
      'fr': 'Printemps',
      'hi': 'वसंत',
    },
    audioAssets: {
      'en': 'assets/audio/season_cycle/en/Pro-Spring.mp3',
      'es': 'assets/audio/season_cycle/es/Pro-Primavera.mp3',
    },
    explanationAudio: 'assets/audio/season_cycle/stages/SCEX-S1-Spring.mp3',
    animationAsset: 'assets/animations/season_cycle/SeasonCycle_Stage 1.gif',
  ),
  CycleStage(
    name: 'Summer',
    description: 'Summer is the hottest season with long days and plenty of sunshine.',
    imageAsset: 'assets/images/season_cycle/summer.png',
    translations: {
      'es': 'Verano',
      'fr': 'Été',
      'hi': 'ग्रीष्म',
    },
    audioAssets: {
      'en': 'assets/audio/season_cycle/en/Pro-Summer.mp3',
      'es': 'assets/audio/season_cycle/es/Pro-Verano.mp3',
    },
    explanationAudio: 'assets/audio/season_cycle/stages/SCEX-S2-Summer.mp3',
    animationAsset: 'assets/animations/season_cycle/SeasonCycle_Stage 2.gif',
  ),
  CycleStage(
    name: 'Autumn',
    description: 'Autumn brings falling leaves and cooler temperatures as nature prepares for winter.',
    imageAsset: 'assets/images/season_cycle/autumn.png',
    translations: {
      'es': 'Otoño',
      'fr': 'Automne',
      'hi': 'शरद',
    },
    audioAssets: {
      'en': 'assets/audio/season_cycle/en/Pro-Autumn.mp3',
      'es': 'assets/audio/season_cycle/es/Pro-Otono.mp3',
    },
    explanationAudio: 'assets/audio/season_cycle/stages/SCEX-S3-Autumn.mp3',
    animationAsset: 'assets/animations/season_cycle/SeasonCycle_Stage 3.gif',
  ),
  CycleStage(
    name: 'Winter',
    description: 'Winter is the coldest season with short days and often snow and ice.',
    imageAsset: 'assets/images/season_cycle/winter.png',
    translations: {
      'es': 'Invierno',
      'fr': 'Hiver',
      'hi': 'शीत',
    },
    audioAssets: {
      'en': 'assets/audio/season_cycle/en/Pro-Winter.mp3',
      'es': 'assets/audio/season_cycle/es/Pro-Invierno.mp3',
    },
    explanationAudio: 'assets/audio/season_cycle/stages/SCEX-S4-Winter.mp3',
    animationAsset: 'assets/animations/season_cycle/SeasonCycle_Stage 4.gif',
  ),
]; 
final List<CycleStage> butterflyCycleStages = [
  CycleStage(
    name: 'Egg',
    description: 'The butterfly life cycle begins as a tiny egg, often laid on a leaf.',
    imageAsset: 'assets/images/butterfly_cycle/eggs.png',
    translations: {
      'es': 'Huevo',
      'fr': 'Œuf',
      'hi': 'अंडा',
    },
    audioAssets: {
      'en': 'assets/audio/butterfly_cycle/en/Pro-Egg.mp3',
      'es': 'assets/audio/butterfly_cycle/es/Pro-Huevo.mp3',
    },
    explanationAudio: 'assets/audio/butterfly_cycle/stages/BCEX-S1-Egg.mp3',
    animationAsset: 'assets/animations/butterfly_cycle/ButterflyCycle_Stage1.gif',
  ),
  CycleStage(
    name: 'Caterpillar',
    description: 'The egg hatches into a caterpillar (larva), which eats leaves and grows quickly.',
    imageAsset: 'assets/images/butterfly_cycle/caterpillar.png',
    translations: {
      'es': 'Oruga',
      'fr': 'Chenille',
      'hi': 'इल्ली',
    },
    audioAssets: {
      'en': 'assets/audio/butterfly_cycle/en/Pro-Caterpillar.mp3',
      'es': 'assets/audio/butterfly_cycle/es/Pro-Oruga.mp3',
    },
    explanationAudio: 'assets/audio/butterfly_cycle/stages/BCEX-S2-Caterpillar.mp3',
    animationAsset: 'assets/animations/butterfly_cycle/ButterflyCycle_Stage2.gif',
  ),
  CycleStage(
    name: 'Pupa',
    description: 'The caterpillar forms a pupa (chrysalis), where it transforms into a butterfly.',
    imageAsset: 'assets/images/butterfly_cycle/pupa.png',
    translations: {
      'es': 'Crisálida',
      'fr': 'Chrysalide',
      'hi': 'कोष',
    },
    audioAssets: {
      'en': 'assets/audio/butterfly_cycle/en/Pro-Pupa.mp3',
      'es': 'assets/audio/butterfly_cycle/es/Pro-Crisalida.mp3',
    },
    explanationAudio: 'assets/audio/butterfly_cycle/stages/BCEX-S3-Pupa.mp3',
    animationAsset: 'assets/animations/butterfly_cycle/ButterflyCycle_Stage3.gif',
  ),
  CycleStage(
    name: 'Adult Butterfly',
    description: 'The adult butterfly emerges from the chrysalis, ready to start the cycle again.',
    imageAsset: 'assets/images/butterfly_cycle/butterfly.png',
    translations: {
      'es': 'Mariposa Adulta',
      'fr': 'Papillon Adulte',
      'hi': 'वयस्क तितली',
    },
    audioAssets: {
      'en': 'assets/audio/butterfly_cycle/en/Pro-AdultButterfly.mp3',
      'es': 'assets/audio/butterfly_cycle/es/Pro-MariposaAdulta.mp3',
    },
    explanationAudio: 'assets/audio/butterfly_cycle/stages/BCEX-S4-AdultButterfly.mp3',
    animationAsset: 'assets/animations/butterfly_cycle/ButterflyCycle_Stage4.gif',
  ),
];