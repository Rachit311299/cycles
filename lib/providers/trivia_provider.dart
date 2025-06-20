import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trivia_question.dart';

final plantCycleTriviaProvider = Provider<List<TriviaQuestion>>((ref) {
  return [
    TriviaQuestion(
      question: 'What is the first stage of a plant\'s life cycle?',
      options: ['Seed', 'Seedling', 'Adult Plant', 'Flower'],
      correctAnswerIndex: 0,
      explanation: 'A plant\'s life cycle begins as a seed, which contains the plant embryo and stored food.',
    ),
    TriviaQuestion(
      question: 'What does a seed need to germinate?',
      options: [
        'Only sunlight',
        'Water, air, and suitable temperature',
        'Only water',
        'Only warm temperature'
      ],
      correctAnswerIndex: 1,
      explanation: 'Seeds need water, air, and the right temperature to begin germination.',
    ),
    TriviaQuestion(
      question: 'What happens during germination?',
      options: [
        'The plant produces flowers',
        'The seed coat breaks and a root emerges',
        'Leaves start producing food',
        'Seeds are dispersed'
      ],
      correctAnswerIndex: 1,
      explanation: 'During germination, the seed absorbs water, the seed coat breaks, and the first root (radicle) emerges.',
    ),
  ];
});

final waterCycleTriviaProvider = Provider<List<TriviaQuestion>>((ref) {
  return [
    TriviaQuestion(
      question: 'What is evaporation in the water cycle?',
      options: [
        'Water turning into ice',
        'Water vapor turning into liquid',
        'Liquid water turning into water vapor',
        'Water moving through plants'
      ],
      correctAnswerIndex: 2,
      explanation: 'Evaporation occurs when liquid water is heated by the sun and turns into water vapor.',
    ),
    TriviaQuestion(
      question: 'What is condensation in the water cycle?',
      options: [
        'Water vapor cooling and forming clouds',
        'Water falling from clouds as rain',
        'Water flowing in rivers',
        'Ice melting into liquid water'
      ],
      correctAnswerIndex: 0,
      explanation: 'Condensation happens when water vapor cools and changes from a gas back to a liquid, forming clouds in the atmosphere.',
    ),
    TriviaQuestion(
      question: 'Which of these is NOT a form of precipitation?',
      options: [
        'Rain',
        'Snow',
        'Hail',
        'Evaporation'
      ],
      correctAnswerIndex: 3,
      explanation: 'Evaporation is the process of water turning into vapor, while precipitation refers to water falling from clouds as rain, snow, sleet, or hail.',
    ),
    TriviaQuestion(
      question: 'What drives the water cycle?',
      options: [
        'Wind',
        'The sun\'s energy',
        'Earth\'s rotation',
        'Ocean currents'
      ],
      correctAnswerIndex: 1,
      explanation: 'The sun\'s energy powers the water cycle by heating water to cause evaporation, which starts the cycle.',
    ),
    TriviaQuestion(
      question: 'What is transpiration?',
      options: [
        'Water evaporating from soil',
        'Water falling as rain',
        'Water released by plants into the air',
        'Water flowing in rivers'
      ],
      correctAnswerIndex: 2,
      explanation: 'Transpiration is the process where plants release water vapor through small pores in their leaves.',
    ),
    TriviaQuestion(
      question: 'What happens during infiltration?',
      options: [
        'Water evaporates from the ocean',
        'Water seeps into the ground',
        'Water forms clouds',
        'Water falls as precipitation'
      ],
      correctAnswerIndex: 1,
      explanation: 'Infiltration occurs when water soaks into the soil and becomes groundwater.',
    ),
    TriviaQuestion(
      question: 'Which part of the water cycle returns water to the oceans?',
      options: [
        'Evaporation',
        'Condensation',
        'Runoff',
        'Precipitation'
      ],
      correctAnswerIndex: 2,
      explanation: 'Runoff is the flow of water over land, which eventually returns water to streams, rivers, and ultimately to oceans.',
    ),
  ];
});

final rockCycleTriviaProvider = Provider<List<TriviaQuestion>>((ref) {
  return [
    TriviaQuestion(
      question: 'What type of rock is formed from cooled magma?',
      options: [
        'Sedimentary rock',
        'Metamorphic rock',
        'Igneous rock',
        'Composite rock'
      ],
      correctAnswerIndex: 2,
      explanation: 'Igneous rocks form when magma cools and solidifies, either above or below Earth\'s surface.',
    ),
    TriviaQuestion(
      question: 'How are sedimentary rocks formed?',
      options: [
        'From cooled magma',
        'From heat and pressure',
        'From compressed sediments',
        'From volcanic eruptions'
      ],
      correctAnswerIndex: 2,
      explanation: 'Sedimentary rocks form when sediments (small pieces of rock) are compressed and cemented together over time.',
    ),
    TriviaQuestion(
      question: 'What process forms metamorphic rocks?',
      options: [
        'Cooling of magma',
        'Compression of sediments',
        'Heat and pressure',
        'Weathering and erosion'
      ],
      correctAnswerIndex: 2,
      explanation: 'Metamorphic rocks form when existing rocks are changed by heat and pressure deep within the Earth.',
    ),
    TriviaQuestion(
      question: 'Which rock type is most likely to contain fossils?',
      options: [
        'Igneous rock',
        'Sedimentary rock',
        'Metamorphic rock',
        'All of these'
      ],
      correctAnswerIndex: 1,
      explanation: 'Fossils are most commonly found in sedimentary rocks because they form in layers that can preserve remains.',
    ),
    TriviaQuestion(
      question: 'What happens to rocks during the rock cycle?',
      options: [
        'They stay the same type forever',
        'They can change from one type to another',
        'They only form from magma',
        'They only form from sediments'
      ],
      correctAnswerIndex: 1,
      explanation: 'Rocks can change from one type to another through various processes in the rock cycle.',
    ),
    TriviaQuestion(
      question: 'Which process breaks down rocks into smaller pieces?',
      options: [
        'Metamorphism',
        'Weathering',
        'Cementation',
        'Crystallization'
      ],
      correctAnswerIndex: 1,
      explanation: 'Weathering is the process that breaks down rocks into smaller pieces through physical or chemical means.',
    ),
  ];
});

final seasonCycleTriviaProvider = Provider<List<TriviaQuestion>>((ref) {
  return [
    TriviaQuestion(
      question: 'Which season comes after winter?',
      options: ['Summer', 'Autumn', 'Spring', 'None of these'],
      correctAnswerIndex: 2,
      explanation: 'Spring follows winter, bringing new life and warmer temperatures.',
    ),
    TriviaQuestion(
      question: 'What is the hottest season?',
      options: ['Spring', 'Summer', 'Autumn', 'Winter'],
      correctAnswerIndex: 1,
      explanation: 'Summer is typically the hottest season with the longest days.',
    ),
    TriviaQuestion(
      question: 'Which season is known for falling leaves?',
      options: ['Spring', 'Summer', 'Autumn', 'Winter'],
      correctAnswerIndex: 2,
      explanation: 'Autumn (or Fall) is characterized by trees shedding their leaves.',
    ),
    TriviaQuestion(
      question: 'What causes the seasons to change?',
      options: [
        'The Earth\'s rotation',
        'The Earth\'s tilt and orbit around the sun',
        'The moon\'s position',
        'The sun\'s temperature changes'
      ],
      correctAnswerIndex: 1,
      explanation: 'The Earth\'s tilt and its orbit around the sun cause the changing seasons.',
    ),
    TriviaQuestion(
      question: 'Which season has the shortest days?',
      options: ['Spring', 'Summer', 'Autumn', 'Winter'],
      correctAnswerIndex: 3,
      explanation: 'Winter has the shortest days and longest nights.',
    ),
  ];
});

final butterflyCycleTriviaProvider = Provider<List<TriviaQuestion>>((ref) {
  return [
    TriviaQuestion(
      question: 'What is the first stage of a butterfly\'s life cycle?',
      options: ['Egg', 'Caterpillar', 'Pupa', 'Adult Butterfly'],
      correctAnswerIndex: 0,
      explanation: 'The butterfly life cycle begins as a tiny egg, usually laid on a leaf.',
    ),
    TriviaQuestion(
      question: 'What does a caterpillar do most of the time?',
      options: [
        'Sleep',
        'Eat leaves and grow',
        'Fly',
        'Lay eggs'
      ],
      correctAnswerIndex: 1,
      explanation: 'Caterpillars (larvae) spend most of their time eating and growing rapidly.',
    ),
    TriviaQuestion(
      question: 'What is the stage called when a caterpillar transforms inside a hard case?',
      options: [
        'Egg',
        'Pupa',
        'Adult Butterfly',
        'Larva'
      ],
      correctAnswerIndex: 1,
      explanation: 'The pupa (chrysalis) is the stage where the caterpillar transforms into a butterfly.',
    ),
    TriviaQuestion(
      question: 'What happens after the butterfly emerges from the pupa?',
      options: [
        'It lays eggs immediately',
        'It dries its wings and then flies away',
        'It eats leaves',
        'It returns to the pupa'
      ],
      correctAnswerIndex: 1,
      explanation: 'After emerging, the butterfly dries its wings before flying away to continue the cycle.',
    ),
    TriviaQuestion(
      question: 'What is the main purpose of the adult butterfly stage?',
      options: [
        'To eat leaves',
        'To grow bigger',
        'To reproduce and lay eggs',
        'To form a pupa'
      ],
      correctAnswerIndex: 2,
      explanation: 'The adult butterfly\'s main purpose is to reproduce and lay eggs, starting the cycle again.',
    ),
  ];
});

final frogCycleTriviaProvider = Provider<List<TriviaQuestion>>((ref) {
  return [
    TriviaQuestion(
      question: 'What is the first stage of a frog\'s life cycle?',
      options: ['Egg', 'Tadpole', 'Froglet', 'Adult Frog'],
      correctAnswerIndex: 0,
      explanation: 'The frog life cycle begins as a tiny egg, usually laid in water.',
    ),
    TriviaQuestion(
      question: 'What does a tadpole use to breathe?',
      options: [
        'Lungs',
        'Gills',
        'Skin',
        'Both gills and lungs'
      ],
      correctAnswerIndex: 1,
      explanation: 'Tadpoles breathe through gills while living in water.',
    ),
    TriviaQuestion(
      question: 'What happens during the froglet stage?',
      options: [
        'The frog lays eggs',
        'The tadpole develops legs and lungs',
        'The frog hibernates',
        'The frog changes color'
      ],
      correctAnswerIndex: 1,
      explanation: 'During the froglet stage, the tadpole develops legs and lungs, preparing for life on land.',
    ),
    TriviaQuestion(
      question: 'What is the main difference between a froglet and an adult frog?',
      options: [
        'The froglet is larger',
        'The froglet has a tail',
        'The adult frog can reproduce',
        'The adult frog lives in water'
      ],
      correctAnswerIndex: 2,
      explanation: 'The main difference is that adult frogs are capable of reproduction, while froglets are not yet mature.',
    ),
    TriviaQuestion(
      question: 'Where do frogs typically lay their eggs?',
      options: [
        'On land',
        'In water',
        'In trees',
        'Underground'
      ],
      correctAnswerIndex: 1,
      explanation: 'Frogs typically lay their eggs in water to keep them moist and provide a suitable environment for tadpoles.',
    ),
  ];
}); 