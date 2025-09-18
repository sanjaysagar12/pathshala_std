import 'package:flutter/material.dart';

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
    switch (widget.subjectName) {
      case 'Mathematics':
        return [
          {
            'question': 'What is the result of 15 + 27?',
            'options': ['40', '42', '41', '43'],
            'correctAnswer': 1,
            'explanation': '15 + 27 = 42. This is basic addition.',
          },
          {
            'question': 'If x = 5, what is the value of 2x + 3?',
            'options': ['10', '13', '8', '15'],
            'correctAnswer': 1,
            'explanation': '2(5) + 3 = 10 + 3 = 13',
          },
          {
            'question': 'What is the area of a rectangle with length 8 and width 6?',
            'options': ['14', '28', '48', '64'],
            'correctAnswer': 2,
            'explanation': 'Area = length × width = 8 × 6 = 48 square units',
          },
          {
            'question': 'Which of these is a prime number?',
            'options': ['15', '21', '17', '25'],
            'correctAnswer': 2,
            'explanation': '17 is prime because it can only be divided by 1 and itself.',
          },
          {
            'question': 'What is 25% of 80?',
            'options': ['15', '20', '25', '30'],
            'correctAnswer': 1,
            'explanation': '25% of 80 = (25/100) × 80 = 20',
          },
        ];
      case 'Science':
        return [
          {
            'question': 'What is the chemical symbol for water?',
            'options': ['H2O', 'CO2', 'NaCl', 'O2'],
            'correctAnswer': 0,
            'explanation': 'Water is composed of 2 hydrogen atoms and 1 oxygen atom: H2O',
          },
          {
            'question': 'Which planet is closest to the Sun?',
            'options': ['Venus', 'Mercury', 'Earth', 'Mars'],
            'correctAnswer': 1,
            'explanation': 'Mercury is the innermost planet in our solar system.',
          },
          {
            'question': 'What force pulls objects toward Earth?',
            'options': ['Magnetism', 'Friction', 'Gravity', 'Pressure'],
            'correctAnswer': 2,
            'explanation': 'Gravity is the force that attracts objects toward the center of Earth.',
          },
          {
            'question': 'At what temperature does water freeze?',
            'options': ['0°C', '32°C', '100°C', '-10°C'],
            'correctAnswer': 0,
            'explanation': 'Water freezes at 0°C (32°F) under normal atmospheric pressure.',
          },
          {
            'question': 'Which gas do plants absorb from the air?',
            'options': ['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen'],
            'correctAnswer': 2,
            'explanation': 'Plants absorb CO2 from the air during photosynthesis.',
          },
        ];
      case 'English':
        return [
          {
            'question': 'Which word is a noun?',
            'options': ['Run', 'Beautiful', 'House', 'Quickly'],
            'correctAnswer': 2,
            'explanation': 'House is a noun - it names a place or thing.',
          },
          {
            'question': 'What is the past tense of "go"?',
            'options': ['Gone', 'Going', 'Went', 'Goes'],
            'correctAnswer': 2,
            'explanation': 'The past tense of "go" is "went".',
          },
          {
            'question': 'Which sentence is correct?',
            'options': [
              'I are happy',
              'I is happy', 
              'I am happy',
              'I be happy'
            ],
            'correctAnswer': 2,
            'explanation': 'The correct form is "I am happy" - using the correct verb form.',
          },
          {
            'question': 'What type of word is "slowly"?',
            'options': ['Noun', 'Verb', 'Adjective', 'Adverb'],
            'correctAnswer': 3,
            'explanation': 'Slowly is an adverb - it describes how an action is performed.',
          },
          {
            'question': 'Which punctuation mark ends a question?',
            'options': ['.', '!', '?', ','],
            'correctAnswer': 2,
            'explanation': 'Questions end with a question mark (?).',
          },
        ];
      default:
        return [
          {
            'question': 'What is a fundamental concept in ${widget.subjectName}?',
            'options': [
              'Basic principles and theories',
              'Advanced applications only',
              'Historical facts only',
              'Memorization techniques'
            ],
            'correctAnswer': 0,
            'explanation': 'Fundamental concepts include basic principles and theories that form the foundation.',
          },
          {
            'question': 'How should you approach learning ${widget.subjectName}?',
            'options': [
              'Only through memorization',
              'Understanding concepts and practice',
              'Reading once is enough',
              'Avoiding difficult topics'
            ],
            'correctAnswer': 1,
            'explanation': 'Effective learning combines understanding concepts with regular practice.',
          },
          {
            'question': 'What helps in mastering ${widget.subjectName}?',
            'options': [
              'Skipping practice',
              'Regular study and application',
              'Only theoretical knowledge',
              'Avoiding questions'
            ],
            'correctAnswer': 1,
            'explanation': 'Regular study and practical application help in mastering any subject.',
          },
        ];
    }
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

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectName} - Quiz'),
        backgroundColor: widget.subjectColor.withOpacity(0.1),
        foregroundColor: widget.subjectColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.subjectColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI-Powered Quiz',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.subjectColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${quizQuestions.length}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / quizQuestions.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(widget.subjectColor),
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
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          currentQuestion['question'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
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
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            elevation: isSelected ? 4 : 2,
                            child: InkWell(
                              onTap: () => _selectAnswer(index),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: isSelected 
                                      ? widget.subjectColor.withOpacity(0.1)
                                      : Colors.transparent,
                                  border: isSelected 
                                      ? Border.all(color: widget.subjectColor, width: 2)
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected 
                                            ? widget.subjectColor 
                                            : Colors.grey[300],
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(65 + index),
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isSelected ? widget.subjectColor : Colors.black87,
                                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
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
                      ),
                      child: const Text('Previous'),
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
                    ),
                    child: Text(
                      currentQuestionIndex < quizQuestions.length - 1 
                          ? 'Next' 
                          : 'Finish Quiz',
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
