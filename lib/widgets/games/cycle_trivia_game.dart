import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../custom_button.dart';
import '../../models/trivia_question.dart';

class CycleTriviaGame extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final Color buttonColor;
  final List<TriviaQuestion> questions;

  const CycleTriviaGame({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.buttonColor,
    required this.questions,
  });

  @override
  State<CycleTriviaGame> createState() => _CycleTriviaGameState();
}

class _CycleTriviaGameState extends State<CycleTriviaGame> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool hasAnswered = false;
  int correctAnswers = 0;
  bool showExplanation = false;

  void _checkAnswer() {
    if (selectedAnswerIndex == null) return;

    setState(() {
      hasAnswered = true;
      if (selectedAnswerIndex == widget.questions[currentQuestionIndex].correctAnswerIndex) {
        correctAnswers++;
      }
      showExplanation = true;
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        hasAnswered = false;
        showExplanation = false;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    final percentage = correctAnswers / widget.questions.length;
    final isHighScore = percentage >= 0.7;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Trophy or achievement icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: widget.buttonColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isHighScore ? Icons.emoji_events : Icons.school,
                      size: 50,
                      color: widget.buttonColor,
                    ),
                  ),
                  if (isHighScore)
                    Positioned(
                      right: -10,
                      top: -10,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Score text with animation
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 800),
                tween: Tween<double>(begin: 0, end: percentage),
                builder: (context, double value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: value,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            percentage >= 0.7 ? Colors.green : widget.buttonColor,
                          ),
                          strokeWidth: 8,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${(value * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'PoetsenOne',
                              color: percentage >= 0.7 ? Colors.green : widget.buttonColor,
                            ),
                          ),
                          Text(
                            '$correctAnswers/${widget.questions.length}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              
              Text(
                'Quiz Complete!',
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: 'PoetsenOne',
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              
              Text(
                _getResultMessage(percentage),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 48,
                      width: double.infinity,
                      cornerRadius: 12,
                      buttonColor: Colors.grey.shade200,
                      onPressed: () {
                        context.pop(); // Close dialog
                        context.pop(); // Return to games menu
                      },
                      child: const Text(
                        'Exit',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      height: 48,
                      width: double.infinity,
                      cornerRadius: 12,
                      buttonColor: widget.buttonColor,
                      onPressed: () {
                        context.pop(); // Close dialog
                        setState(() {
                          currentQuestionIndex = 0;
                          selectedAnswerIndex = null;
                          hasAnswered = false;
                          correctAnswers = 0;
                          showExplanation = false;
                        });
                      },
                      child: const Text(
                        'Try Again',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getResultMessage(double percentage) {
    if (percentage >= 0.9) return 'Excellent! You\'re a cycle expert! 🌟';
    if (percentage >= 0.7) return 'Great job! Keep learning! 👏';
    if (percentage >= 0.5) return 'Good effort! Try again to improve! 💪';
    return 'Keep practicing to learn more! 📚';
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with progress
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: widget.buttonColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black87),
                          onPressed: () => context.pop(),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'PoetsenOne',
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Question ${currentQuestionIndex + 1} of ${widget.questions.length}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontFamily: 'PoetsenOne',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: (currentQuestionIndex + 1) / widget.questions.length,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(widget.buttonColor),
                        minHeight: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Question
                    Container(
                      margin: const EdgeInsets.all(24),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: widget.buttonColor.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'PoetsenOne',
                          color: Colors.black87,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Options
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: question.options.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedAnswerIndex == index;
                          final isCorrect = hasAnswered && index == question.correctAnswerIndex;
                          final isWrong = hasAnswered && isSelected && !isCorrect;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: CustomButton(
                              height: 76,
                              width: double.infinity,
                              cornerRadius: 20,
                              buttonColor: isCorrect
                                  ? Colors.green.withOpacity(0.9)
                                  : isWrong
                                      ? Colors.red.withOpacity(0.9)
                                      : isSelected
                                          ? widget.buttonColor
                                          : Colors.white,
                              onPressed: hasAnswered ? null : () {
                                setState(() {
                                  selectedAnswerIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    if (!hasAnswered && !isSelected)
                                      BoxShadow(
                                        color: widget.buttonColor.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      margin: const EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected || isCorrect
                                            ? Colors.white.withOpacity(0.2)
                                            : Colors.white,
                                        border: Border.all(
                                          color: isSelected || isCorrect
                                              ? Colors.white
                                              : widget.buttonColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(65 + index),
                                          style: TextStyle(
                                            color: isSelected || isCorrect
                                                ? Colors.white
                                                : widget.buttonColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'PoetsenOne',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        question.options[index],
                                        style: TextStyle(
                                          color: isSelected || isCorrect || isWrong
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2,
                                          fontFamily: 'PoetsenOne',
                                        ),
                                      ),
                                    ),
                                    if (hasAnswered)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 16),
                                        child: AnimatedSwitcher(
                                          duration: const Duration(milliseconds: 300),
                                          child: Icon(
                                            isCorrect
                                                ? Icons.check_circle
                                                : isWrong
                                                    ? Icons.cancel
                                                    : null,
                                            color: Colors.white,
                                            size: 32,
                                            key: ValueKey(isCorrect),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Explanation
                    if (showExplanation && question.explanation != null)
                      Container(
                        margin: const EdgeInsets.all(24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: widget.buttonColor.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lightbulb,
                                  color: widget.buttonColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Explanation',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PoetsenOne',
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              question.explanation!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Action button
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: CustomButton(
                height: 56,
                width: double.infinity,
                cornerRadius: 16,
                buttonColor: widget.buttonColor,
                text: hasAnswered ? 'Next Question' : 'Check Answer',
                onPressed: selectedAnswerIndex == null
                    ? null
                    : hasAnswered
                        ? _nextQuestion
                        : _checkAnswer,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 