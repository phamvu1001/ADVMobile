import 'package:flutter/material.dart';
import 'package:jarvis/src/models/chat_bot/chat_bot.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/services/chatBotServices.dart';
import 'package:provider/provider.dart';

class PromptTab extends StatefulWidget {
  final ChatBot chatBot;
  const PromptTab({Key? key, required this.chatBot}) : super(key: key);

  @override
  _PromptTabState createState() => _PromptTabState();
}

class _PromptTabState extends State<PromptTab> {
  late TextEditingController _promptController;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController(text: widget.chatBot.instructions);
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _updateInstructions(String kbToken) async {
    String prompt = _promptController.text;

    await ChatBotServices().updateChatBot(kbToken: kbToken, assistantId: widget.chatBot.id, assistantName: widget.chatBot.assistantName, description: widget.chatBot.description, instructions: prompt);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Instructions updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter your prompts for the assistant:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Flexible(
            child: TextField(
              controller: _promptController,
              maxLines: null, // Allows the text field to expand vertically
              decoration: InputDecoration(
                hintText: 'Type your prompts here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => _updateInstructions(authProvider.knowledgeBaseToken!),
            child: const Text('Save')
          )
        ],
      ),
    );
  }
}
