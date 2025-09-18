import 'package:flutter/material.dart';

class AIChatComponent extends StatefulWidget {
  final String subjectName;
  final Color subjectColor;
  final String? currentTopic;

  const AIChatComponent({
    super.key,
    required this.subjectName,
    required this.subjectColor,
    this.currentTopic,
  });

  @override
  State<AIChatComponent> createState() => _AIChatComponentState();
}

class _AIChatComponentState extends State<AIChatComponent> {
  final TextEditingController _chatController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _chatMessages.add({
      'sender': 'ai',
      'message': 'Hi! I\'m here to help you with ${widget.subjectName}${widget.currentTopic != null ? ' - ${widget.currentTopic}' : ''}. Ask me anything!',
    });
  }

  void _sendMessage() {
    if (_chatController.text.trim().isNotEmpty) {
      setState(() {
        _chatMessages.add({
          'sender': 'user',
          'message': _chatController.text.trim(),
        });
        
        // Simulate AI response based on context
        String aiResponse = _generateAIResponse(_chatController.text.trim());
        
        _chatMessages.add({
          'sender': 'ai',
          'message': aiResponse,
        });
      });
      
      _chatController.clear();
      
      // Scroll to bottom after adding messages
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
  }

  String _generateAIResponse(String userMessage) {
    String message = userMessage.toLowerCase();
    String topicContext = widget.currentTopic != null 
        ? ' regarding "${widget.currentTopic}"' 
        : '';
    
    // Simple AI response logic based on keywords
    if (message.contains('explain') || message.contains('what is')) {
      return 'Great question about ${widget.subjectName}$topicContext! Let me break this down for you. This concept involves several key components that work together. Would you like me to explain any specific part in more detail?';
    } else if (message.contains('example') || message.contains('give me')) {
      return 'Here\'s a practical example for ${widget.subjectName}$topicContext: This is commonly seen in real-world applications. The key is understanding how the principles apply in different contexts. Do you need more examples?';
    } else if (message.contains('how') || message.contains('steps')) {
      return 'Here\'s how to approach this in ${widget.subjectName}$topicContext:\n\n1. Start with the fundamentals\n2. Apply the core principles\n3. Practice with examples\n4. Verify your understanding\n\nWhich step would you like me to elaborate on?';
    } else if (message.contains('difficult') || message.contains('hard')) {
      return 'I understand this part of ${widget.subjectName} can be challenging! Let\'s break it down into smaller, manageable pieces. What specific aspect is giving you trouble? I\'m here to help make it clearer.';
    } else if (message.contains('quiz') || message.contains('test')) {
      return 'Ready for a quick quiz on ${widget.subjectName}$topicContext? I can create practice questions to test your understanding. What type of questions would you prefer - multiple choice, true/false, or open-ended?';
    } else {
      return 'That\'s an interesting question about ${widget.subjectName}$topicContext! Based on what we\'re studying, I can help clarify this concept. The key points to remember are the fundamental principles and their practical applications. What specific aspect would you like me to focus on?';
    }
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.subjectColor.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(color: widget.subjectColor.withOpacity(0.2)),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.subjectColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.smart_toy,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Assistant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: widget.subjectColor,
                      ),
                    ),
                    Text(
                      'Ask me anything about ${widget.subjectName}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.currentTopic != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: widget.subjectColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Current Topic',
                    style: TextStyle(
                      fontSize: 10,
                      color: widget.subjectColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
        
        // Chat Messages
        Expanded(
          child: _chatMessages.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Start a conversation!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ask me to explain concepts, provide examples,\nor help with practice questions',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = _chatMessages[index];
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
                            CircleAvatar(
                              backgroundColor: widget.subjectColor,
                              radius: 16,
                              child: const Icon(
                                Icons.smart_toy, 
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
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
                                    : Colors.grey[200],
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
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                          if (isUser) ...[
                            const SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.grey[400],
                              radius: 16,
                              child: const Icon(
                                Icons.person, 
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
        ),
        
        // Input Area
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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _chatController,
                    decoration: const InputDecoration(
                      hintText: 'Type your question...',
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
                  borderRadius: BorderRadius.circular(24),
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
    );
  }
}
