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
  int currentTopicIndex = 0;
  bool showAIChat = false;
  final TextEditingController _chatController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];

  List<Map<String, String>> get subjectTopics {
    switch (widget.subjectName) {
      case 'Mathematics':
        return [
          {
            'title': 'Topic 1: Introduction to Algebra',
            'content': 'Algebra is a fundamental branch of mathematics that uses letters and symbols to represent numbers and quantities in formulas and equations. In this topic, we\'ll explore:\n\n• Variables and constants\n• Basic algebraic expressions\n• Simple equations\n• Order of operations\n\nAlgebra helps us solve real-world problems by creating mathematical models.',
          },
          {
            'title': 'Topic 2: Linear Equations',
            'content': 'Linear equations are equations where the highest power of the variable is 1. They form straight lines when graphed.\n\n• Standard form: ax + b = 0\n• Slope-intercept form: y = mx + b\n• Solving linear equations\n• Applications in real life\n\nLinear equations are used in business, physics, and many other fields.',
          },
          {
            'title': 'Topic 3: Quadratic Equations',
            'content': 'Quadratic equations contain variables raised to the second power and form parabolic curves when graphed.\n\n• Standard form: ax² + bx + c = 0\n• Factoring methods\n• Quadratic formula\n• Graphing parabolas\n\nQuadratic equations model many natural phenomena like projectile motion.',
          },
        ];
      case 'Science':
        return [
          {
            'title': 'Topic 1: States of Matter',
            'content': 'Matter exists in different states based on the arrangement and movement of particles.\n\n• Solid: Fixed shape and volume\n• Liquid: Fixed volume, takes container shape\n• Gas: No fixed shape or volume\n• Plasma: Highly energized gas\n\nChanges between states occur with temperature and pressure variations.',
          },
          {
            'title': 'Topic 2: Chemical Reactions',
            'content': 'Chemical reactions involve the rearrangement of atoms to form new substances.\n\n• Reactants and products\n• Types of reactions\n• Conservation of mass\n• Reaction rates\n\nChemical reactions are essential for life processes and industrial applications.',
          },
          {
            'title': 'Topic 3: Energy and Motion',
            'content': 'Energy is the ability to do work and comes in various forms.\n\n• Kinetic energy: Energy of motion\n• Potential energy: Stored energy\n• Conservation of energy\n• Newton\'s laws of motion\n\nUnderstanding energy helps explain natural phenomena and technological applications.',
          },
        ];
      default:
        return [
          {
            'title': 'Topic 1: Introduction to ${widget.subjectName}',
            'content': 'Welcome to the study of ${widget.subjectName}. This introductory topic covers the fundamental concepts and principles that form the foundation of this subject.\n\n• Key terminology\n• Basic concepts\n• Historical context\n• Real-world applications\n\nUnderstanding these basics will help you progress to more advanced topics.',
          },
          {
            'title': 'Topic 2: Core Principles',
            'content': 'This topic explores the core principles and theories that govern ${widget.subjectName}.\n\n• Fundamental laws\n• Key relationships\n• Problem-solving approaches\n• Practical examples\n\nMastering these principles is essential for advanced study in this field.',
          },
          {
            'title': 'Topic 3: Advanced Concepts',
            'content': 'Building on the foundation, this topic introduces more complex concepts in ${widget.subjectName}.\n\n• Advanced theories\n• Complex applications\n• Research methods\n• Current developments\n\nThese concepts prepare you for specialized study and professional applications.',
          },
        ];
    }
  }

  void _nextTopic() {
    if (currentTopicIndex < subjectTopics.length - 1) {
      setState(() {
        currentTopicIndex++;
      });
    }
  }

  void _changeTopic() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Topic'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: subjectTopics.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(subjectTopics[index]['title']!),
              selected: index == currentTopicIndex,
              onTap: () {
                setState(() {
                  currentTopicIndex = index;
                });
                Navigator.pop(context);
              },
            ),
          ),
        ),
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
    final currentTopic = subjectTopics[currentTopicIndex];
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Topic Header
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
                  currentTopic['title']!,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: widget.subjectColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Progress: ${currentTopicIndex + 1}/${subjectTopics.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (currentTopicIndex + 1) / subjectTopics.length,
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
                  onPressed: currentTopicIndex < subjectTopics.length - 1 
                      ? _nextTopic 
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
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
    final currentTopic = subjectTopics[currentTopicIndex];
    return AIChatComponent(
      subjectName: widget.subjectName,
      subjectColor: widget.subjectColor,
      currentTopic: currentTopic['title'],
    );
  }
}