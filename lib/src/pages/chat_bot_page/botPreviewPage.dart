import 'package:flutter/material.dart';
import 'package:jarvis/src/models/chat_bot/chat_bot.dart';
import 'package:jarvis/src/pages/chat_bot_page/previewTab.dart';
import 'package:jarvis/src/pages/chat_bot_page/promptTab.dart';
import 'package:jarvis/src/pages/chat_bot_page/knowledgeTab.dart';
import 'package:jarvis/src/pages/chat_bot_page/publishPage.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/services/chatBotServices.dart';
import 'package:provider/provider.dart';

class BotPreviewPage extends StatefulWidget {
  final String botName;
  final String botId;

  BotPreviewPage({super.key, required this.botId, required this.botName});

  @override
  _BotPreviewPageState createState() => _BotPreviewPageState();
}

class _BotPreviewPageState extends State<BotPreviewPage> {
  late Future<ChatBot> _chatBotFuture;
  bool _isUpdated = false;

  @override
  void initState() {
    super.initState();
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    _chatBotFuture = fetchChatBot(widget.botId, authProvider.knowledgeBaseToken!);
  }

  Future<ChatBot> fetchChatBot(String botId, String kbToken) async {
    // Replace with your actual API call
    final data = await ChatBotServices().getChatBot(assistantId: botId, kbToken: kbToken);

    return ChatBot.fromJson(data);
  }

  void _showModifyDialog(ChatBot chatBot, String kbToken) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController(text: chatBot.assistantName);
        final TextEditingController descriptionController = TextEditingController(text: chatBot.description);

        return AlertDialog(
          title: const Text('Modify Chat Bot'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String assistantName = nameController.text;
                String description = descriptionController.text;
                final data = await ChatBotServices().updateChatBot(kbToken: kbToken, assistantId: chatBot.id, assistantName: assistantName, description: description, instructions: '');
                setState(() {
                  _chatBotFuture = Future.value(ChatBot.fromJson(data));
                  _isUpdated = true;
                });
                Navigator.pop(context, 'updated');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

    return FutureBuilder<ChatBot>(
      future: _chatBotFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final chatBot = snapshot.data!;
          return DefaultTabController(
            length: 3,
            initialIndex: 1,
            child: Scaffold(
              appBar: AppBar(
                // title: Text(widget.botName),
                title: Row(
                  children: [
                    Expanded(child: Text(chatBot.assistantName)),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showModifyDialog(chatBot, authProvider.knowledgeBaseToken!),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PublishPage(
                              botId: widget.botId,
                              botName: widget.botName,
                            ),
                          ),
                        );
                      },
                      child: const Text('Publish')
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context, _isUpdated ? 'updated' : null);
                  },
                ),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Prompt'),
                    Tab(text: 'Preview'),
                    Tab(text: 'Knowledge'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  PromptTab(chatBot: chatBot),
                  PreviewTab(chatBot: chatBot),
                  KnowledgeTab(chatbot: chatBot)
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}