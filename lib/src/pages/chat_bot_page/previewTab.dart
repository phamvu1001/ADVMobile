import 'package:flutter/material.dart';
import 'package:jarvis/src/models/chat_bot/chat_bot.dart';

class PreviewTab extends StatefulWidget {
  final ChatBot chatBot;

  const PreviewTab({Key? key, required this.chatBot}) : super(key: key);

  @override
  _PreviewTabState createState() => _PreviewTabState();
}

class _PreviewTabState extends State<PreviewTab> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'sender': 'user',
          'message': _messageController.text,
        });
        _messageController.clear();
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add({
            'sender': 'Assistant',
            'message': 'Hello, how can I help you?',
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              final isUser = message['sender'] == 'user';
              return Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue[300] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(isUser ? Icons.person : Icons.android),
                          const SizedBox(width: 8.0),
                          Text(isUser ? 'You' : 'Assistant'),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(message['message']!),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onSubmitted: (value) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8.0),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
