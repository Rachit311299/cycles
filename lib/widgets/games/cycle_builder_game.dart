import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../custom_button.dart';
import 'game_results_dialog.dart';

class CycleStageItem {
  final String name;
  final String imageAsset;
  final int correctOrder;

  CycleStageItem({
    required this.name,
    required this.imageAsset,
    required this.correctOrder,
  });
}

class CycleBuilderGame extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final Color buttonColor;
  final List<CycleStageItem> stages;

  const CycleBuilderGame({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.buttonColor,
    required this.stages,
  }) : super(key: key);

  @override
  State<CycleBuilderGame> createState() => _CycleBuilderGameState();
}

class _CycleBuilderGameState extends State<CycleBuilderGame> {
  late List<CycleStageItem> shuffledStages;
  List<CycleStageItem?> orderedStages = [];
  List<bool> incorrectPositions = [];
  bool showSuccess = false;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      shuffledStages = List.from(widget.stages)..shuffle();
      orderedStages = List.filled(widget.stages.length, null);
      incorrectPositions = List.filled(widget.stages.length, false);
      showSuccess = false;
    });
  }

  bool checkOrder() {
    if (orderedStages.contains(null)) return false;
    
    bool isCorrect = true;
    setState(() {
      incorrectPositions = List.generate(orderedStages.length, (index) {
        bool correct = orderedStages[index]?.correctOrder == index;
        if (!correct) isCorrect = false;
        return !correct;
      });
    });
    return isCorrect;
  }

  void showFeedback(bool isCorrect) {
    if (isCorrect) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Great job! You completed the cycle!',
            style: TextStyle(fontFamily: 'PoetsenOne'),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Count incorrect positions
      int wrongCount = incorrectPositions.where((wrong) => wrong).length;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You have $wrongCount incorrect positions. Try again!',
            style: const TextStyle(fontFamily: 'PoetsenOne'),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showResults() {
    final correctCount = orderedStages.asMap().entries
        .where((entry) => entry.value?.correctOrder == entry.key)
        .length;
    final score = correctCount / widget.stages.length;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GameResultsDialog(
        score: score,
        correct: correctCount,
        total: widget.stages.length,
        themeColor: widget.buttonColor,
        gameType: 'Cycle Builder',
        onTryAgain: () {
          setState(() {
            resetGame();
          });
        },
      ),
    );
  }

  Widget _buildDropTarget(int index) {
    bool isIncorrect = incorrectPositions[index];
    
    return DragTarget<CycleStageItem>(
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          final oldIndex = orderedStages.indexOf(data);
          if (oldIndex != -1) {
            orderedStages[oldIndex] = null;
            incorrectPositions[oldIndex] = false;
          } else {
            shuffledStages.remove(data);
          }
          
          if (orderedStages[index] != null && !shuffledStages.contains(orderedStages[index])) {
            shuffledStages.add(orderedStages[index]!);
          }
          
          orderedStages[index] = data;
          incorrectPositions[index] = false;
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isIncorrect 
                ? Colors.red.withOpacity(0.1)
                : orderedStages[index] == null
                    ? widget.buttonColor.withOpacity(0.1)
                    : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isIncorrect
                  ? Colors.red.withOpacity(0.5)
                  : widget.buttonColor.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              if (orderedStages[index] != null)
                BoxShadow(
                  color: isIncorrect
                      ? Colors.red.withOpacity(0.1)
                      : widget.buttonColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isIncorrect
                      ? Colors.red.withOpacity(0.2)
                      : widget.buttonColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isIncorrect
                          ? Colors.red
                          : widget.buttonColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PoetsenOne',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    orderedStages[index] == null
                        ? Center(
                            child: Text(
                              'Drop stage here',
                              style: TextStyle(
                                color: isIncorrect
                                    ? Colors.red.withOpacity(0.5)
                                    : widget.buttonColor.withOpacity(0.5),
                                fontSize: 16,
                                fontFamily: 'PoetsenOne',
                              ),
                            ),
                          )
                        : _buildStageItem(orderedStages[index]!, isIncorrect: isIncorrect),
                    if (orderedStages[index] != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (orderedStages[index] != null) {
                                shuffledStages.add(orderedStages[index]!);
                                orderedStages[index] = null;
                                incorrectPositions[index] = false;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (isIncorrect && orderedStages[index] != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button and title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'PoetsenOne',
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            // Game instructions
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Arrange the stages in the correct order',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontFamily: 'PoetsenOne',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: widget.buttonColor),
                    onPressed: resetGame,
                  ),
                ],
              ),
            ),
            // Drop target area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: orderedStages.length,
                  itemBuilder: (context, index) => _buildDropTarget(index),
                ),
              ),
            ),
            // Draggable items area
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: shuffledStages.map((stage) {
                  return Draggable<CycleStageItem>(
                    data: stage,
                    feedback: SizedBox(
                      width: 100,
                      height: 100,
                      child: _buildStageItem(stage, isDragging: true),
                    ),
                    childWhenDragging: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: widget.buttonColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 16),
                      child: _buildStageItem(stage),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Check button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                height: 56,
                width: double.infinity,
                cornerRadius: 12,
                buttonColor: widget.buttonColor,
                text: 'Check Order',
                onPressed: () {
                  final isCorrect = checkOrder();
                  showFeedback(isCorrect);
                  if (isCorrect) {
                    setState(() {
                      showSuccess = true;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageItem(CycleStageItem stage, {bool isDragging = false, bool isIncorrect = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isIncorrect
            ? Colors.red.withOpacity(0.1)
            : widget.buttonColor.withOpacity(isDragging ? 0.9 : 0.2),
        borderRadius: BorderRadius.circular(12),
        border: isIncorrect
            ? Border.all(color: Colors.red.withOpacity(0.5))
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                stage.imageAsset,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stage.name,
            style: TextStyle(
              color: isIncorrect
                  ? Colors.red
                  : isDragging ? Colors.white : Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
} 