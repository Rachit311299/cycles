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
    // Add more water cycle questions...
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
    // Add more rock cycle questions...
  ];
}); 