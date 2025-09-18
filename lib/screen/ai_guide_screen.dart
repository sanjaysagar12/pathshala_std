import 'package:flutter/material.dart';

class AIGuideScreen extends StatefulWidget {
  final String subjectName;
  final Color subjectColor;

  const AIGuideScreen({
    super.key,
    required this.subjectName,
    required this.subjectColor,
  });

  @override
  State<AIGuideScreen> createState() => _AIGuideScreenState();
}

class _AIGuideScreenState extends State<AIGuideScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add({
      'sender': 'ai',
      'message': 'Hello! I\'m your AI Guide for ${widget.subjectName}. I\'m here to help you understand concepts, answer questions, and provide personalized learning guidance. What would you like to explore today?',
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final userMessage = _messageController.text.trim();
      
      setState(() {
        _messages.add({
          'sender': 'user',
          'message': userMessage,
        });
      });

      _messageController.clear();
      
      // Simulate AI response
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          _messages.add({
            'sender': 'ai',
            'message': _generateAIResponse(userMessage),
          });
        });
        _scrollToBottom();
      });
      
      _scrollToBottom();
    }
  }

  String _generateAIResponse(String userMessage) {
    String message = userMessage.toLowerCase();
    
    // Comprehensive AI responses based on different types of queries
    if (message.contains('hello') || message.contains('hi') || message.contains('hey')) {
      return 'Hello! Great to see you\'re ready to learn ${widget.subjectName}. I can help you with:\n\n✓ Explaining complex concepts\n✓ Providing step-by-step solutions\n✓ Creating study plans\n✓ Practice questions\n✓ Learning tips and strategies\n\nWhat specific topic would you like to explore?';
    } 
    else if (message.contains('explain') || message.contains('what is') || message.contains('define')) {
      return 'I\'d love to explain that concept to you! In ${widget.subjectName}, this topic involves several key components:\n\n• Core principles and definitions\n• Real-world applications\n• Common examples and scenarios\n• How it connects to other concepts\n\nTo give you the most helpful explanation, could you tell me your current level of understanding? Are you a beginner or do you have some background knowledge?';
    }
    else if (message.contains('study plan') || message.contains('schedule') || message.contains('how to study')) {
      return 'Great question! Here\'s a personalized study approach for ${widget.subjectName}:\n\n📚 **Daily Study Plan:**\n• 20-30 minutes of concept review\n• Practice problems or examples\n• Quick recap of previous topics\n\n🎯 **Weekly Goals:**\n• Master 2-3 new concepts\n• Complete practice exercises\n• Review and reinforce learning\n\n💡 **Study Tips:**\n• Break complex topics into smaller parts\n• Use real-world examples\n• Practice regularly\n• Ask questions when stuck\n\nWould you like me to create a specific plan for any particular topic?';
    }
    else if (message.contains('difficult') || message.contains('hard') || message.contains('struggling') || message.contains('confused')) {
      return 'I understand that ${widget.subjectName} can be challenging sometimes! That\'s completely normal. Let\'s break this down:\n\n🔍 **Identify the Challenge:**\n• What specific part is confusing?\n• Where do you get stuck?\n• What feels overwhelming?\n\n💪 **My Approach:**\n• Simplify complex concepts\n• Use analogies and examples\n• Step-by-step explanations\n• Practice with easier problems first\n\n✨ Remember: Every expert was once a beginner! I\'m here to guide you through each step. What specific topic would you like help with?';
    }
    else if (message.contains('practice') || message.contains('exercise') || message.contains('problem') || message.contains('question')) {
      return 'Excellent! Practice is key to mastering ${widget.subjectName}. Here\'s how I can help:\n\n📝 **Practice Options:**\n• Step-by-step problem solving\n• Guided practice sessions\n• Difficulty-appropriate exercises\n• Instant feedback and explanations\n\n🎯 **Practice Strategy:**\n1. Start with fundamentals\n2. Gradually increase complexity\n3. Focus on understanding, not just answers\n4. Learn from mistakes\n\nWhat type of problems would you like to practice? Basic concepts, intermediate applications, or advanced challenges?';
    }
    else if (message.contains('test') || message.contains('exam') || message.contains('quiz') || message.contains('assessment')) {
      return 'I can definitely help you prepare for assessments in ${widget.subjectName}! Here\'s my exam preparation strategy:\n\n📖 **Study Preparation:**\n• Review key concepts and formulas\n• Practice different question types\n• Create summary notes\n• Identify weak areas for extra focus\n\n⏰ **Test-Taking Tips:**\n• Read questions carefully\n• Manage your time effectively\n• Show your work step-by-step\n• Review answers if time permits\n\n🎯 **Practice Tests:**\nI can create custom practice questions based on your syllabus. Would you like to start with specific topics or a comprehensive review?';
    }
    else if (message.contains('help') || message.contains('assist') || message.contains('support')) {
      return 'I\'m here to provide comprehensive support for your ${widget.subjectName} journey! Here\'s how I can assist:\n\n🎓 **Learning Support:**\n• Concept explanations with examples\n• Problem-solving strategies\n• Study techniques and tips\n• Progress tracking and motivation\n\n🤔 **Question Types I Handle:**\n• "How do I solve...?"\n• "Why does this work?"\n• "Can you explain...?"\n• "What\'s the best way to...?"\n\n💬 **Interactive Learning:**\nFeel free to ask follow-up questions, request clarifications, or dive deeper into any topic. I adapt my responses to your learning style!\n\nWhat would you like to start with today?';
    }
    else if (message.contains('thank') || message.contains('thanks')) {
      return 'You\'re very welcome! I\'m glad I could help with your ${widget.subjectName} studies. 😊\n\nRemember:\n• Keep practicing regularly\n• Don\'t hesitate to ask questions\n• Celebrate small victories\n• Stay curious and keep learning!\n\nI\'m always here whenever you need guidance or have more questions. What else would you like to explore?';
    }
    else {
      // Default comprehensive response
      return 'That\'s an interesting question about ${widget.subjectName}! Let me help you with that.\n\n🔍 **Understanding Your Question:**\nI want to make sure I give you the most helpful response. This topic connects to several important concepts in ${widget.subjectName}.\n\n💡 **Key Points to Consider:**\n• Fundamental principles involved\n• Practical applications\n• Common misconceptions to avoid\n• Best approaches to master this\n\n📚 **Next Steps:**\nCould you provide a bit more context? For example:\n• What specific aspect interests you most?\n• What\'s your current understanding level?\n• Are there particular examples you\'d like me to use?\n\nThis will help me tailor my explanation perfectly for you!';
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Guide - ${widget.subjectName}'),
        backgroundColor: widget.subjectColor.withOpacity(0.1),
        foregroundColor: widget.subjectColor,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _messages.clear();
                _messages.add({
                  'sender': 'ai',
                  'message': 'Chat cleared! I\'m your AI Guide for ${widget.subjectName}. How can I help you today?',
                });
              });
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Clear Chat',
          ),
        ],
      ),
      body: Column(
        children: [
          // AI Guide Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.subjectColor.withOpacity(0.1),
                  widget.subjectColor.withOpacity(0.2),
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.subjectColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.psychology,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Personal AI Guide',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.subjectColor,
                        ),
                      ),
                      Text(
                        'Ask me anything about ${widget.subjectName}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isUser 
                        ? MainAxisAlignment.end 
                        : MainAxisAlignment.start,
                    children: [
                      if (!isUser) ...[
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: widget.subjectColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.psychology,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isUser 
                                ? widget.subjectColor 
                                : Colors.grey[100],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: isUser 
                                  ? const Radius.circular(16) 
                                  : const Radius.circular(4),
                              bottomRight: isUser 
                                  ? const Radius.circular(4) 
                                  : const Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            message['message']!,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 12),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Ask me anything about this subject...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      maxLines: null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: widget.subjectColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                    iconSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
