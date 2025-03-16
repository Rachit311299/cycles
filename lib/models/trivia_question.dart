import 'package:flutter/material.dart';

class TriviaQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String? explanation;

  const TriviaQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation,
  });
}

class TriviaQuiz {
  final String title;
  final List<TriviaQuestion> questions;
  final Color themeColor;

  const TriviaQuiz({
    required this.title,
    required this.questions,
    required this.themeColor,
  });
} 