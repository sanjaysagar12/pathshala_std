import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatefulWidget {
  final String subjectName;
  final Color subjectColor;

  const QuizScreen({
    super.key,
    required this.subjectName,
    required this.subjectColor,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<int?> selectedAnswers = [];
  bool quizCompleted = false;
  int score = 0;

  List<Map<String, dynamic>> get quizQuestions {
    return QuizData.getQuizQuestions(widget.subjectName);
  }

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(quizQuestions.length, null);
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = answerIndex;
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _finishQuiz();
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _finishQuiz() {
    int correctAnswers = 0;
    for (int i = 0; i < quizQuestions.length; i++) {
      if (selectedAnswers[i] == quizQuestions[i]['correctAnswer']) {
        correctAnswers++;
      }
    }
    setState(() {
      score = correctAnswers;
      quizCompleted = true;
    });
  }

  void _restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswers = List.filled(quizQuestions.length, null);
      quizCompleted = false;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quizCompleted) {
      return _buildResultsPage();
    }

    final currentQuestion = quizQuestions[currentQuestionIndex];
    final hasAnswer = selectedAnswers[currentQuestionIndex] != null;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Gradient progressGradient = LinearGradient(
      colors: [widget.subjectColor, widget.subjectColor.withOpacity(0.7)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectName} - Quiz', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: colorScheme.surface,
        foregroundColor: widget.subjectColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header
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
                    'AI-Powered Quiz',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.subjectColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${quizQuestions.length}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: (currentQuestionIndex + 1) / quizQuestions.length),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    ...List.generate(
                      currentQuestion['options'].length,
                      (index) {
                        final option = currentQuestion['options'][index];
                        final isSelected = selectedAnswers[currentQuestionIndex] == index;

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
                                          String.fromCharCode(65 + index),
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
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            const SizedBox(height: 16),
            Row(
              children: [
                if (currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousQuestion,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: widget.subjectColor,
                        side: BorderSide(color: widget.subjectColor),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Previous', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    ),
                  ),
                if (currentQuestionIndex > 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: hasAnswer ? _nextQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.subjectColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      currentQuestionIndex < quizQuestions.length - 1 
                          ? 'Next' 
                          : 'Finish Quiz',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsPage() {
    final percentage = (score / quizQuestions.length * 100).round();
    final isPassed = percentage >= 60;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectName} - Quiz Results'),
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
              isPassed ? Icons.celebration : Icons.refresh,
              size: 100,
              color: isPassed ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 20),
            Text(
              isPassed ? 'Great Job!' : 'Keep Learning!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isPassed ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$percentage%',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$score out of ${quizQuestions.length} correct',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            
            // Results Summary
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
                    'Quiz Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.subjectColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Correct', score.toString(), Colors.green),
                      _buildStatItem('Incorrect', (quizQuestions.length - score).toString(), Colors.red),
                      _buildStatItem('Score', '$percentage%', widget.subjectColor),
                    ],
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _restartQuiz,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: widget.subjectColor,
                      side: BorderSide(color: widget.subjectColor),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Retake Quiz'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.subjectColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Back to Subject'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
