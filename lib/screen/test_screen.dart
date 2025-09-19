import 'package:flutter/material.dart';
import '../data/test_data.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class TestScreen extends StatefulWidget {
  final String subjectName;
  final Color subjectColor;
  final String lessonTitle;

  const TestScreen({
    super.key,
    required this.subjectName,
    required this.subjectColor,
    required this.lessonTitle,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentQuestionIndex = 0;
  List<int> selectedAnswers = [];
  bool showResults = false;

  List<Map<String, dynamic>> get testQuestions {
    return TestData.getTestQuestions(widget.subjectName);
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      if (selectedAnswers.length <= currentQuestionIndex) {
        selectedAnswers.add(answerIndex);
      } else {
        selectedAnswers[currentQuestionIndex] = answerIndex;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < testQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    setState(() {
      showResults = true;
    });
  }

  int get correctAnswers {
    int correct = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == testQuestions[i]['correctAnswer']) {
        correct++;
      }
    }
    return correct;
  }

  double get scorePercentage => (correctAnswers / testQuestions.length) * 100;

  @override
  Widget build(BuildContext context) {
    if (showResults) {
      return _buildResultsScreen();
    }

    final currentQuestion = testQuestions[currentQuestionIndex];
    final hasSelectedAnswer = selectedAnswers.length > currentQuestionIndex;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Gradient progressGradient = LinearGradient(
      colors: [widget.subjectColor, widget.subjectColor.withOpacity(0.7)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectName} - Test', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: colorScheme.surface,
        foregroundColor: widget.subjectColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Test Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: colorScheme.surface.withOpacity(0.8),
                boxShadow: [
                  BoxShadow(
                    color: widget.subjectColor.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.lessonTitle,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: widget.subjectColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lesson Test',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: widget.subjectColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${testQuestions.length}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: (currentQuestionIndex + 1) / testQuestions.length),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: colorScheme.surface.withOpacity(0.3),
                            ),
                          ),
                          Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width * value * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: progressGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: widget.subjectColor.withOpacity(0.18),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Question
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  currentQuestion['question'],
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Options
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion['options'].length,
                itemBuilder: (context, index) {
                  final option = currentQuestion['options'][index];
                  final isSelected = hasSelectedAnswer && 
                      selectedAnswers[currentQuestionIndex] == index;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    child: Card(
                      elevation: isSelected ? 6 : 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: InkWell(
                        onTap: () => _selectAnswer(index),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: isSelected 
                                ? widget.subjectColor.withOpacity(0.13)
                                : Colors.transparent,
                            border: isSelected 
                                ? Border.all(color: widget.subjectColor, width: 2)
                                : null,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected 
                                      ? widget.subjectColor 
                                      : colorScheme.surface.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + index), // A, B, C, D
                                    style: GoogleFonts.inter(
                                      color: isSelected ? Colors.white : colorScheme.onSurface.withOpacity(0.7),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  option,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: isSelected ? widget.subjectColor : colorScheme.onSurface,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Next Button
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: hasSelectedAnswer ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.subjectColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  currentQuestionIndex < testQuestions.length - 1 
                      ? 'Next Question' 
                      : 'Finish Test',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final isPassed = scorePercentage >= 70;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectName} - Test Results'),
        backgroundColor: widget.subjectColor.withOpacity(0.1),
        foregroundColor: widget.subjectColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Icon(
              isPassed ? Icons.check_circle : Icons.cancel,
              size: 100,
              color: isPassed ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              isPassed ? 'Congratulations!' : 'Keep Practicing!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isPassed ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${scorePercentage.toInt()}%',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$correctAnswers out of ${testQuestions.length} correct',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.subjectColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    widget.lessonTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.subjectColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isPassed 
                        ? 'You have successfully completed this lesson!'
                        : 'Review the lesson content and try again.',
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: widget.subjectColor,
                      side: BorderSide(color: widget.subjectColor),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Review Lesson'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.subjectColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Back to Home'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
