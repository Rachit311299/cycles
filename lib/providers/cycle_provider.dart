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

final frogCycleProvider = StateNotifierProvider<CycleNotifier, int>((ref) {
  return CycleNotifier(stages: frogCycleStages);
});

final dayNightCycleProvider = StateNotifierProvider<CycleNotifier, int>((ref) {
  return CycleNotifier(stages: dayNightCycleStages);
});

final moonCycleProvider = StateNotifierProvider<CycleNotifier, int>((ref) {
  return CycleNotifier(stages: moonCycleStages);
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
      'en': 'assets/audio/plant_cycle/en/Pro-Seeds.mp3',
      'es': 'assets/audio/plant_cycle/es/Pro-Semilias.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/plant_cycle/stages/en/PCEXen-S1-Seeds.mp3',
      'es': 'assets/audio/plant_cycle/stages/es/PCEXes-S1-Seeds.mp3',
    },
    explanationSubtitles: 'assets/subtitles/plant_cycle/stages/PCEX-S1-Seeds.srt',
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
      'en': 'assets/audio/plant_cycle/en/Pro-Germination.mp3',
      'es': 'assets/audio/plant_cycle/es/Pro-Germinacion.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/plant_cycle/stages/en/PCEXen-S2-Germination.mp3',
      'es': 'assets/audio/plant_cycle/stages/es/PCEXes-S2-Germination.mp3',
    },
    explanationSubtitles: 'assets/subtitles/plant_cycle/stages/PCEX-S2-Germination.srt',
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
      'en': 'assets/audio/plant_cycle/en/Pro-Seedling.mp3',
      'es': 'assets/audio/plant_cycle/es/Pro-plantula.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/plant_cycle/stages/en/PCEXen-S3-Seedling.mp3',
      'es': 'assets/audio/plant_cycle/stages/es/PCEXes-S3-Seedling.mp3',
    },
    explanationSubtitles: 'assets/subtitles/plant_cycle/stages/PCEX-S3-Seedling.srt',
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
      'en': 'assets/audio/plant_cycle/en/Pro-Adultplant.mp3',
      'es': 'assets/audio/plant_cycle/es/Pro-planatadulta.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/plant_cycle/stages/en/PCEXen-S4-AdultPlant.mp3',
      'es': 'assets/audio/plant_cycle/stages/es/PCEXes-S4-AdultPlant.mp3',
    },
    explanationSubtitles: 'assets/subtitles/plant_cycle/stages/PCEX-S4-AdultPlant.srt',
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
      'en': 'assets/audio/plant_cycle/en/Pro-Flowering.mp3',
      'es': 'assets/audio/plant_cycle/es/Pro-Floracion.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/plant_cycle/stages/en/PCEXen-S5-Flowering.mp3',
      'es': 'assets/audio/plant_cycle/stages/es/PCEXes-S5-Flowering.mp3',
    },
    explanationSubtitles: 'assets/subtitles/plant_cycle/stages/PCEX-S5-Flowering.srt',
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
      'en': 'assets/audio/water_cycle/en/Pro-Evaporation.mp3',
      'es': 'assets/audio/water_cycle/es/Pro-Evaporacion.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/water_cycle/stages/en/WCEXen-S1-Evaporation.mp3',
      'es': 'assets/audio/water_cycle/stages/es/WCEXes-S1-Evaporation.mp3',
    },
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
      'en': 'assets/audio/water_cycle/en/Pro-Condensation.mp3',
      'es': 'assets/audio/water_cycle/es/Pro-Condensacion.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/water_cycle/stages/en/WCEXen-S2-Condensation.mp3',
      'es': 'assets/audio/water_cycle/stages/es/WCEXes-S2-Condensation.mp3',
    },
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
      'en': 'assets/audio/water_cycle/en/Pro-Precipitation.mp3',
      'es': 'assets/audio/water_cycle/es/Pro-Precipitacion.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/water_cycle/stages/en/WCEXen-S3-Precipitation.mp3',
      'es': 'assets/audio/water_cycle/stages/es/WCEXes-S3-Precipitation.mp3',
    },
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
      'en': 'assets/audio/water_cycle/en/Pro-Groundwaterflow.mp3',
      'es': 'assets/audio/water_cycle/es/Pro-FlujodeAguaSubterranea.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/water_cycle/stages/en/WCEXen-S4-Groundwater.mp3',
      'es': 'assets/audio/water_cycle/stages/es/WCEXes-S4-Groundwater.mp3',
    },
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
      'en': 'assets/audio/water_cycle/en/Pro-Collection.mp3',
      'es': 'assets/audio/water_cycle/es/Pro-Acumulacion.mp3',
    },
    explanationAudioAssets: {
      'en': 'assets/audio/water_cycle/stages/en/WCEXen-S5-Collection.mp3',
      'es': 'assets/audio/water_cycle/stages/es/WCEXes-S5-Collection.mp3',
    },
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

final List<CycleStage> frogCycleStages = [
  CycleStage(
    name: 'Egg',
    description: 'The frog life cycle begins as a tiny egg, usually laid in water.',
    imageAsset: 'assets/images/frog_cycle/frog_egg.png',
    translations: {
      'es': 'Huevo',
      'fr': 'Œuf',
      'hi': 'अंडा',
    },
    audioAssets: {
      'en': 'assets/audio/frog_cycle/en/Pro-frog_egg.mp3',
      'es': 'assets/audio/frog_cycle/es/Pro-Huevo.mp3',
    },
    explanationAudio: 'assets/audio/frog_cycle/stages/FCEX-S1-frog_egg.mp3',
    animationAsset: 'assets/animations/frog_cycle/FrogCycle_Stage1.gif',
  ),
  CycleStage(
    name: 'Tadpole',
    description: 'The egg hatches into a tadpole, which lives in water and breathes through gills.',
    imageAsset: 'assets/images/frog_cycle/tadpole.png',
    translations: {
      'es': 'Renacuajo',
      'fr': 'Têtard',
      'hi': 'टैडपोल',
    },
    audioAssets: {
      'en': 'assets/audio/frog_cycle/en/Pro-Tadpole.mp3',
      'es': 'assets/audio/frog_cycle/es/Pro-Renacuajo.mp3',
    },
    explanationAudio: 'assets/audio/frog_cycle/stages/FCEX-S2-Tadpole.mp3',
    animationAsset: 'assets/animations/frog_cycle/FrogCycle_Stage2.gif',
  ),
  CycleStage(
    name: 'Froglet',
    description: 'The tadpole develops legs and lungs, becoming a froglet.',
    imageAsset: 'assets/images/frog_cycle/froglet.png',
    translations: {
      'es': 'Rana Joven',
      'fr': 'Jeune Grenouille',
      'hi': 'छोटा मेंढक',
    },
    audioAssets: {
      'en': 'assets/audio/frog_cycle/en/Pro-Froglet.mp3',
      'es': 'assets/audio/frog_cycle/es/Pro-RanaJoven.mp3',
    },
    explanationAudio: 'assets/audio/frog_cycle/stages/FCEX-S3-Froglet.mp3',
    animationAsset: 'assets/animations/frog_cycle/FrogCycle_Stage3.gif',
  ),
  CycleStage(
    name: 'Adult Frog',
    description: 'The froglet completes its transformation into an adult frog, ready to reproduce.',
    imageAsset: 'assets/images/frog_cycle/adult_frog.png',
    translations: {
      'es': 'Rana Adulta',
      'fr': 'Grenouille Adulte',
      'hi': 'वयस्क मेंढक',
    },
    audioAssets: {
      'en': 'assets/audio/frog_cycle/en/Pro-AdultFrog.mp3',
      'es': 'assets/audio/frog_cycle/es/Pro-RanaAdulta.mp3',
    },
    explanationAudio: 'assets/audio/frog_cycle/stages/FCEX-S4-AdultFrog.mp3',
    animationAsset: 'assets/animations/frog_cycle/FrogCycle_Stage4.gif',
  ),
];

final List<CycleStage> dayNightCycleStages = [
  CycleStage(
    name: 'Sunrise',
    description: 'The sun rises in the east, marking the beginning of a new day with beautiful colors in the sky.',
    imageAsset: 'assets/images/day_night_cycle/sunrise.jpg',
    translations: {
      'es': 'Amanecer',
      'fr': 'Lever du soleil',
      'hi': 'सूर्योदय',
    },
    audioAssets: {
      'en': 'assets/audio/day_night_cycle/en/Pro-Sunrise.mp3',
      'es': 'assets/audio/day_night_cycle/es/Pro-Amanecer.mp3',
    },
    explanationAudio: 'assets/audio/day_night_cycle/stages/DNCEX-S1-Sunrise.mp3',
    animationAsset: 'assets/animations/day_night_cycle/DayNightCycle_Stage1.gif',
  ),
  CycleStage(
    name: 'Morning',
    description: 'Morning brings bright sunlight and the start of daily activities as the day begins.',
    imageAsset: 'assets/images/day_night_cycle/morning.jpg',
    translations: {
      'es': 'Mañana',
      'fr': 'Matin',
      'hi': 'सुबह',
    },
    audioAssets: {
      'en': 'assets/audio/day_night_cycle/en/Pro-Morning.mp3',
      'es': 'assets/audio/day_night_cycle/es/Pro-Manana.mp3',
    },
    explanationAudio: 'assets/audio/day_night_cycle/stages/DNCEX-S2-Morning.mp3',
    animationAsset: 'assets/animations/day_night_cycle/DayNightCycle_Stage2.gif',
  ),
  CycleStage(
    name: 'Afternoon',
    description: 'Afternoon is the middle of the day when the sun is at its highest point in the sky.',
    imageAsset: 'assets/images/day_night_cycle/afternoon.jpg',
    translations: {
      'es': 'Tarde',
      'fr': 'Après-midi',
      'hi': 'दोपहर',
    },
    audioAssets: {
      'en': 'assets/audio/day_night_cycle/en/Pro-Afternoon.mp3',
      'es': 'assets/audio/day_night_cycle/es/Pro-Tarde.mp3',
    },
    explanationAudio: 'assets/audio/day_night_cycle/stages/DNCEX-S3-Afternoon.mp3',
    animationAsset: 'assets/animations/day_night_cycle/DayNightCycle_Stage3.gif',
  ),
  CycleStage(
    name: 'Evening',
    description: 'Evening is when the sun begins to set, creating beautiful colors in the sky as day transitions to night.',
    imageAsset: 'assets/images/day_night_cycle/evening.jpg',
    translations: {
      'es': 'Noche',
      'fr': 'Soir',
      'hi': 'शाम',
    },
    audioAssets: {
      'en': 'assets/audio/day_night_cycle/en/Pro-Evening.mp3',
      'es': 'assets/audio/day_night_cycle/es/Pro-Noche.mp3',
    },
    explanationAudio: 'assets/audio/day_night_cycle/stages/DNCEX-S4-Evening.mp3',
    animationAsset: 'assets/animations/day_night_cycle/DayNightCycle_Stage4.gif',
  ),
  CycleStage(
    name: 'Night',
    description: 'Night is when the sun has set and darkness covers the land, with stars and the moon visible in the sky.',
    imageAsset: 'assets/images/day_night_cycle/night.jpg',
    translations: {
      'es': 'Noche',
      'fr': 'Nuit',
      'hi': 'रात',
    },
    audioAssets: {
      'en': 'assets/audio/day_night_cycle/en/Pro-Night.mp3',
      'es': 'assets/audio/day_night_cycle/es/Pro-Noche.mp3',
    },
    explanationAudio: 'assets/audio/day_night_cycle/stages/DNCEX-S5-Night.mp3',
    animationAsset: 'assets/animations/day_night_cycle/DayNightCycle_Stage5.gif',
  ),
];

final List<CycleStage> moonCycleStages = [
  CycleStage(
    name: 'New Moon',
    description: 'The moon is not visible from Earth as it is positioned between Earth and the sun.',
    imageAsset: 'assets/images/moon_cycle/new_moon.png',
    translations: {
      'es': 'Luna Nueva',
      'fr': 'Nouvelle Lune',
      'hi': 'अमावस्या',
    },
    audioAssets: {
      'en': 'assets/audio/moon_cycle/en/Pro-NewMoon.mp3',
      'es': 'assets/audio/moon_cycle/es/Pro-LunaNueva.mp3',
    },
    explanationAudio: 'assets/audio/moon_cycle/stages/MCEX-S1-NewMoon.mp3',
    animationAsset: 'assets/animations/moon_cycle/MoonCycle_Stage1.gif',
  ),
  CycleStage(
    name: 'Waxing Crescent',
    description: 'A small sliver of the moon becomes visible, appearing to grow from the right side.',
    imageAsset: 'assets/images/moon_cycle/waxing_crescent.png',
    translations: {
      'es': 'Creciente Creciente',
      'fr': 'Premier Croissant',
      'hi': 'वृद्धि होती अर्धचंद्र',
    },
    audioAssets: {
      'en': 'assets/audio/moon_cycle/en/Pro-WaxingCrescent.mp3',
      'es': 'assets/audio/moon_cycle/es/Pro-CrecienteCreciente.mp3',
    },
    explanationAudio: 'assets/audio/moon_cycle/stages/MCEX-S2-WaxingCrescent.mp3',
    animationAsset: 'assets/animations/moon_cycle/MoonCycle_Stage2.gif',
  ),
  CycleStage(
    name: 'First Quarter',
    description: 'Half of the moon is illuminated, appearing as a half circle. Also called half moon.',
    imageAsset: 'assets/images/moon_cycle/first_quarter.png',
    translations: {
      'es': 'Cuarto Creciente',
      'fr': 'Premier Quartier',
      'hi': 'पहला चौथाई',
    },
    audioAssets: {
      'en': 'assets/audio/moon_cycle/en/Pro-FirstQuarter.mp3',
      'es': 'assets/audio/moon_cycle/es/Pro-CuartoCreciente.mp3',
    },
    explanationAudio: 'assets/audio/moon_cycle/stages/MCEX-S3-FirstQuarter.mp3',
    animationAsset: 'assets/animations/moon_cycle/MoonCycle_Stage3.gif',
  ),
  CycleStage(
    name: 'Waxing Gibbous',
    description: 'More than half of the moon is illuminated, continuing to grow toward full moon.',
    imageAsset: 'assets/images/moon_cycle/waxing_gibbous.png',
    translations: {
      'es': 'Gibosa Creciente',
      'fr': 'Gibbeuse Croissante',
      'hi': 'वृद्धि होती गिबस',
    },
    audioAssets: {
      'en': 'assets/audio/moon_cycle/en/Pro-WaxingGibbous.mp3',
      'es': 'assets/audio/moon_cycle/es/Pro-GibosaCreciente.mp3',
    },
    explanationAudio: 'assets/audio/moon_cycle/stages/MCEX-S4-WaxingGibbous.mp3',
    animationAsset: 'assets/animations/moon_cycle/MoonCycle_Stage4.gif',
  ),
  CycleStage(
    name: 'Full Moon',
    description: 'The entire face of the moon is illuminated and appears as a complete circle in the night sky.',
    imageAsset: 'assets/images/moon_cycle/full_moon.png',
    translations: {
      'es': 'Luna Llena',
      'fr': 'Pleine Lune',
      'hi': 'पूर्णिमा',
    },
    audioAssets: {
      'en': 'assets/audio/moon_cycle/en/Pro-FullMoon.mp3',
      'es': 'assets/audio/moon_cycle/es/Pro-LunaLlena.mp3',
    },
    explanationAudio: 'assets/audio/moon_cycle/stages/MCEX-S5-FullMoon.mp3',
    animationAsset: 'assets/animations/moon_cycle/MoonCycle_Stage5.gif',
  ),
  CycleStage(
    name: 'Waning Gibbous',
    description: 'The moon starts to decrease in illumination, appearing to shrink from the left side.',
    imageAsset: 'assets/images/moon_cycle/waning_gibbous.png',
    translations: {
      'es': 'Gibosa Menguante',
      'fr': 'Gibbeuse Décroissante',
      'hi': 'घटती गिबस',
    },
    audioAssets: {
      'en': 'assets/audio/moon_cycle/en/Pro-WaningGibbous.mp3',
      'es': 'assets/audio/moon_cycle/es/Pro-GibosaMenguante.mp3',
    },
    explanationAudio: 'assets/audio/moon_cycle/stages/MCEX-S6-WaningGibbous.mp3',
    animationAsset: 'assets/animations/moon_cycle/MoonCycle_Stage6.gif',
  ),
  CycleStage(
    name: 'Last Quarter',
    description: 'Half of the moon is illuminated, but now on the opposite side from the first quarter.',
    imageAsset: 'assets/images/moon_cycle/last_quarter.png',
    translations: {
      'es': 'Cuarto Menguante',
      'fr': 'Dernier Quartier',
      'hi': 'अंतिम चौथाई',
    },
    audioAssets: {
      'en': 'assets/audio/moon_cycle/en/Pro-LastQuarter.mp3',
      'es': 'assets/audio/moon_cycle/es/Pro-CuartoMenguante.mp3',
    },
    explanationAudio: 'assets/audio/moon_cycle/stages/MCEX-S7-LastQuarter.mp3',
    animationAsset: 'assets/animations/moon_cycle/MoonCycle_Stage7.gif',
  ),
  CycleStage(
    name: 'Waning Crescent',
    description: 'A small sliver of the moon remains visible, appearing to shrink until it becomes a new moon again.',
    imageAsset: 'assets/images/moon_cycle/waning_crescent.png',
    translations: {
      'es': 'Creciente Menguante',
      'fr': 'Dernier Croissant',
      'hi': 'घटती अर्धचंद्र',
    },
    audioAssets: {
      'en': 'assets/audio/moon_cycle/en/Pro-WaningCrescent.mp3',
      'es': 'assets/audio/moon_cycle/es/Pro-CrecienteMenguante.mp3',
    },
    explanationAudio: 'assets/audio/moon_cycle/stages/MCEX-S8-WaningCrescent.mp3',
    animationAsset: 'assets/animations/moon_cycle/MoonCycle_Stage8.gif',
  ),
];