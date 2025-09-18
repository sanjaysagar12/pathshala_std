import 'package:flutter/material.dart';
import '../components/ai_chat_component.dart';

class LearningScreen extends StatefulWidget {
  final String subjectName;
  final Color subjectColor;

  const LearningScreen({
    super.key,
    required this.subjectName,
    required this.subjectColor,
  });

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int currentLessonIndex = 0;
  int currentTopicIndex = 0;
  bool showAIChat = false;

  List<Map<String, dynamic>> get subjectLessons {
    switch (widget.subjectName) {
      case 'Mathematics':
        return [
          {
            'lessonTitle': 'Lesson 1: Algebra Fundamentals',
            'topics': [
              {
                'title': 'Introduction to Algebra',
                'content': 'Algebra is a fundamental branch of mathematics that uses letters and symbols to represent numbers and quantities in formulas and equations. In this topic, we\'ll explore:\n\n• Variables and constants\n• Basic algebraic expressions\n• Simple equations\n• Order of operations\n\nAlgebra helps us solve real-world problems by creating mathematical models.',
              },
              {
                'title': 'Variables and Constants',
                'content': 'Understanding the difference between variables and constants is crucial in algebra:\n\n• Variables: Symbols that represent unknown values (x, y, z)\n• Constants: Fixed numerical values (5, -3, π)\n• Coefficients: Numbers multiplying variables\n• Terms: Individual parts of expressions\n\nMastering these concepts forms the foundation for algebraic problem-solving.',
              },
              {
                'title': 'Algebraic Expressions',
                'content': 'Algebraic expressions combine variables, constants, and operations:\n\n• Simple expressions: 2x + 3\n• Complex expressions: 3x² + 2xy - 5\n• Like terms: Terms with same variables and powers\n• Simplifying expressions\n\nLearning to manipulate expressions is essential for solving equations.',
              },
            ],
          },
          {
            'lessonTitle': 'Lesson 2: Equations and Solutions',
            'topics': [
              {
                'title': 'Linear Equations',
                'content': 'Linear equations are equations where the highest power of the variable is 1. They form straight lines when graphed.\n\n• Standard form: ax + b = 0\n• Slope-intercept form: y = mx + b\n• Solving linear equations\n• Applications in real life\n\nLinear equations are used in business, physics, and many other fields.',
              },
              {
                'title': 'Quadratic Equations',
                'content': 'Quadratic equations contain variables raised to the second power and form parabolic curves when graphed.\n\n• Standard form: ax² + bx + c = 0\n• Factoring methods\n• Quadratic formula\n• Graphing parabolas\n\nQuadratic equations model many natural phenomena like projectile motion.',
              },
            ],
          },
        ];
      case 'Science':
        return [
          {
            'lessonTitle': 'Lesson 1: Matter and Its States',
            'topics': [
              {
                'title': 'States of Matter',
                'content': 'Matter exists in different states based on the arrangement and movement of particles.\n\n• Solid: Fixed shape and volume\n• Liquid: Fixed volume, takes container shape\n• Gas: No fixed shape or volume\n• Plasma: Highly energized gas\n\nChanges between states occur with temperature and pressure variations.',
              },
              {
                'title': 'Particle Theory',
                'content': 'The particle theory explains the behavior of matter:\n\n• All matter is made of tiny particles\n• Particles are in constant motion\n• Temperature affects particle movement\n• Forces between particles vary\n\nThis theory helps us understand phase changes and material properties.',
              },
            ],
          },
          {
            'lessonTitle': 'Lesson 2: Chemical Changes',
            'topics': [
              {
                'title': 'Chemical Reactions',
                'content': 'Chemical reactions involve the rearrangement of atoms to form new substances.\n\n• Reactants and products\n• Types of reactions\n• Conservation of mass\n• Reaction rates\n\nChemical reactions are essential for life processes and industrial applications.',
              },
              {
                'title': 'Energy in Reactions',
                'content': 'Energy changes occur during chemical reactions:\n\n• Exothermic reactions: Release energy\n• Endothermic reactions: Absorb energy\n• Activation energy: Energy needed to start reaction\n• Catalysts: Speed up reactions\n\nUnderstanding energy helps predict reaction behavior.',
              },
            ],
          },
        ];
      default:
        return [
          {
            'lessonTitle': 'Lesson 1: Introduction to ${widget.subjectName}',
            'topics': [
              {
                'title': 'Fundamentals',
                'content': 'Welcome to the study of ${widget.subjectName}. This introductory topic covers the fundamental concepts and principles that form the foundation of this subject.\n\n• Key terminology\n• Basic concepts\n• Historical context\n• Real-world applications\n\nUnderstanding these basics will help you progress to more advanced topics.',
              },
              {
                'title': 'Core Principles',
                'content': 'This topic explores the core principles and theories that govern ${widget.subjectName}.\n\n• Fundamental laws\n• Key relationships\n• Problem-solving approaches\n• Practical examples\n\nMastering these principles is essential for advanced study in this field.',
              },
            ],
          },
        ];
    }
  }

  List<Map<String, String>> get currentTopics => 
      subjectLessons[currentLessonIndex]['topics'] as List<Map<String, String>>;

  void _nextTopic() {
    if (currentTopicIndex < currentTopics.length - 1) {
      setState(() {
        currentTopicIndex++;
      });
    } else if (currentLessonIndex < subjectLessons.length - 1) {
      setState(() {
        currentLessonIndex++;
        currentTopicIndex = 0;
      });
    }
  }

  void _changeTopic() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Lesson & Topic'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Lesson:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.subjectColor,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: widget.subjectColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<int>(
                  value: currentLessonIndex,
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: Icon(Icons.arrow_drop_down, color: widget.subjectColor),
                  items: subjectLessons.asMap().entries.map((entry) {
                    int index = entry.key;
                    String title = entry.value['lessonTitle'];
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text(title),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        currentLessonIndex = newValue;
                        currentTopicIndex = 0; // Reset to first topic
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Choose Topic:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.subjectColor,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: widget.subjectColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<int>(
                  value: currentTopicIndex,
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: Icon(Icons.arrow_drop_down, color: widget.subjectColor),
                  items: currentTopics.asMap().entries.map((entry) {
                    int index = entry.key;
                    String title = entry.value['title']!;
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: widget.subjectColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: widget.subjectColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(title)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        currentTopicIndex = newValue;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select a lesson and topic to jump to that content',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: widget.subjectColor),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.subjectColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectName} - Learning'),
        backgroundColor: widget.subjectColor.withOpacity(0.1),
        foregroundColor: widget.subjectColor,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showAIChat = !showAIChat;
              });
            },
            icon: Icon(showAIChat ? Icons.close : Icons.chat),
          ),
        ],
      ),
      body: showAIChat ? _buildAIChat() : _buildLearningContent(),
    );
  }

  Widget _buildLearningContent() {
    final currentLesson = subjectLessons[currentLessonIndex];
    final currentTopic = currentTopics[currentTopicIndex];
    final totalTopics = subjectLessons.fold<int>(0, (sum, lesson) => sum + (lesson['topics'] as List).length);
    final currentGlobalIndex = subjectLessons.take(currentLessonIndex)
        .fold<int>(0, (sum, lesson) => sum + (lesson['topics'] as List).length) + currentTopicIndex + 1;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lesson & Topic Header
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
                  currentLesson['lessonTitle'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: widget.subjectColor.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentTopic['title']!,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: widget.subjectColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Progress: $currentGlobalIndex/$totalTopics topics',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: currentGlobalIndex / totalTopics,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(widget.subjectColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    currentTopic['content']!,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Navigation Buttons
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _changeTopic,
                  icon: const Icon(Icons.list),
                  label: const Text('Change Topic'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: currentGlobalIndex < totalTopics ? _nextTopic : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(currentTopicIndex < currentTopics.length - 1 ? 'Next Topic' : 'Next Lesson'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.subjectColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIChat() {
    final currentTopic = currentTopics[currentTopicIndex];
    return AIChatComponent(
      subjectName: widget.subjectName,
      subjectColor: widget.subjectColor,
      currentTopic: currentTopic['title'],
    );
  }
}