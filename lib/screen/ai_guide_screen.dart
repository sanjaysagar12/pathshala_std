import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'AI Assistant',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        elevation: 0,
        centerTitle: true,
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
            icon: Icon(Icons.refresh, color: Colors.grey[600]),
            tooltip: 'Clear Chat',
          ),
        ],
      ),
      body: Column(
        children: [
          // Enhanced AI Guide Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.subjectColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.smart_toy_outlined,
                    size: 28,
                    color: widget.subjectColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subjectName,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your personal AI tutor is ready',
                        style: GoogleFonts.inter(
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
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Online',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: widget.subjectColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.smart_toy_outlined,
                            color: widget.subjectColor,
                            size: 18,
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
                                : Colors.white,
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
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            message['message']!,
                            style: GoogleFonts.inter(
                              color: isUser ? Colors.white : Colors.black87,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 12),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.grey[600],
                            size: 18,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Enhanced Message Input
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Ask me anything about ${widget.subjectName}...',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      style: GoogleFonts.inter(fontSize: 14),
                      onSubmitted: (_) => _sendMessage(),
                      maxLines: null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: widget.subjectColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: widget.subjectColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _sendMessage,
                      borderRadius: BorderRadius.circular(24),
                      child: const Center(
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
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
