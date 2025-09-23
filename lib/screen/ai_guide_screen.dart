import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ai/model_engine.dart';
import '../data/lessons_data.dart';

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

  final AIModelService _aiService = AIModelService();
  bool _isModelLoading = true;
  String _loadingMessage = 'Initializing...';
  double? _downloadProgress;

  @override
  void initState() {
    super.initState();
    _initializeModel();
  }

  @override
  void dispose() {
    _cleanupModel();
    super.dispose();
  }

  Future<void> _cleanupModel() async {
    await _aiService.cleanup();
  }

  Future<void> _initializeModel() async {
    if (!mounted) return;

    setState(() {
      _isModelLoading = true;
      _loadingMessage = 'Initializing...';
      _downloadProgress = null;
    });

    try {
      // Delegate initialization to the AI service. It will call back
      // with progress and status updates which we reflect in the UI.
      await _aiService.initialize(
        onProgress: (progress) {
          if (!mounted) return;
          setState(() => _downloadProgress = progress);
        },
        onStatus: (status) {
          if (!mounted) return;
          setState(() => _loadingMessage = status);
        },
      );

      if (!mounted) return;
      setState(() {
        _isModelLoading = false;
        _messages.add({
          'sender': 'ai',
          'message': 'Hello! I\'m your AI Guide for ${widget.subjectName}. I\'m here to help you understand concepts, answer questions, and provide personalized learning guidance. What would you like to explore today?',
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error initializing model: $e");
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to initialize AI model: $e'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isModelLoading = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final userMessage = _messageController.text.trim();
      
      setState(() {
        _messages.add({
          'sender': 'user',
          'message': userMessage,
        });
      });

      _messageController.clear();
      _scrollToBottom();

      try {
        // Ask the service to send the message and stream tokens back.
        setState(() {
          _messages.add({
            'sender': 'ai',
            'message': 'Thinking...',
          });
        });

        // Build external knowledge from lessons for this subject
        final lessonsMap = LessonsData.getSubjectLessons(widget.subjectName);
        final lessonsList = lessonsMap['lessons'] as List<dynamic>? ?? [];
        final StringBuffer knowledge = StringBuffer();
        for (final lesson in lessonsList) {
          final title = lesson['lessonTitle'] ?? '';
          knowledge.writeln('Lesson: $title');
          final topics = lesson['topics'] as List<dynamic>? ?? [];
          for (final topic in topics) {
            final tTitle = topic['title'] ?? '';
            final content = topic['content'] ?? '';
            knowledge.writeln('- $tTitle: $content');
          }
          knowledge.writeln();
        }

        // Truncate knowledge if too large (keep first ~2000 chars)
        var knowledgeText = knowledge.toString();
        const int maxKnowledgeLength = 2000;
        if (knowledgeText.length > maxKnowledgeLength) {
          knowledgeText = knowledgeText.substring(0, maxKnowledgeLength) + '\n...[truncated]';
        }

        // Prompt template: inject lessons as context, keep {input} for user query
        final promptTemplate = '''You are a helpful, accurate tutor. Use the following lessons and topics as the authoritative context when answering. Do NOT make up facts not supported by the lessons. If the answer requires information outside the lessons, say you don't have enough information and give next-best suggestions.

CONTEXT (lessons):
${knowledgeText}

INSTRUCTIONS:
- Answer concisely and in simple language suitable for students.
- Provide step-by-step explanations for problems and short examples when helpful.
- Highlight important formulas or definitions.

QUESTION:
{input}
''';

        final responseStream = _aiService.sendMessageWithTemplate(promptTemplate, userMessage);
        final buffer = StringBuffer();

        await for (final tokenText in responseStream) {
          if (!mounted) return;
          buffer.write(tokenText);
          setState(() {
            _messages.last['message'] = buffer.toString();
          });
          _scrollToBottom();
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error generating response: $e');
        }
        if (!mounted) return;
        
        // Update the message to show the error
        setState(() {
          _messages.last['message'] = 'Sorry, I encountered an error while generating a response. Please try again.';
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate response: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      
      _scrollToBottom();
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
  Widget build(BuildContext context) {
    if (_isModelLoading) {
      // Use splash-screen theme while model initializes/downloads
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo like in SplashScreen
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),

              // Status text
              Text(
                _loadingMessage,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Animated progress bar similar to SplashScreen
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: _downloadProgress ?? 0.15,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.deepOrange, Colors.orange],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
              if (_downloadProgress != null)
                Text(
                  '${(_downloadProgress! * 100).toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'AI Guide - ${widget.subjectName}',
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
