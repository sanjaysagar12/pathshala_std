import 'package:flutter/material.dart';
import '../components/ai_chat_component.dart';
import '../data/lessons_data.dart';

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
    return LessonsData.getSubjectLessons(widget.subjectName)['lessons']!;
  }

  List<Map<String, String>> get currentTopics => 
      subjectLessons[currentLessonIndex]['topics'] as List<Map<String, String>>;

  void _nextTopic() {
    if (currentTopicIndex < currentTopics.length - 1) {
      setState(() {
        currentTopicIndex++;
      });
    } else if (currentLessonIndex < subjectLessons.length - 1) {
      // Navigate to test before going to next lesson
      Navigator.pushNamed(
        context,
        '/test',
        arguments: {
          'subjectName': widget.subjectName,
          'subjectColor': widget.subjectColor,
          'lessonTitle': subjectLessons[currentLessonIndex]['lessonTitle'],
        },
      ).then((_) {
        // After test, move to next lesson
        setState(() {
          currentLessonIndex++;
          currentTopicIndex = 0;
        });
      });
    } else {
      // Last topic of last lesson - go to final test
      Navigator.pushNamed(
        context,
        '/test',
        arguments: {
          'subjectName': widget.subjectName,
          'subjectColor': widget.subjectColor,
          'lessonTitle': 'Final Test - ${widget.subjectName}',
        },
      );
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
                  onPressed: currentGlobalIndex <= totalTopics ? _nextTopic : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(
                    currentTopicIndex < currentTopics.length - 1 
                        ? 'Next Topic' 
                        : currentLessonIndex < subjectLessons.length - 1
                            ? 'Take Test'
                            : 'Final Test'
                  ),
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