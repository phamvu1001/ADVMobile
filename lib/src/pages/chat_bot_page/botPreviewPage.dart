import 'package:flutter/material.dart';
import 'package:jarvis/src/models/chat_bot/chat_bot.dart';
import 'package:jarvis/src/pages/chat_bot_page/previewTab.dart';
import 'package:jarvis/src/pages/chat_bot_page/promptTab.dart';
import 'package:jarvis/src/pages/chat_bot_page/knowledgeTab.dart';
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

  @override
  Widget build(BuildContext context) {
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
                title: Text(widget.botName),
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

// class BotPreviewPage extends StatelessWidget {
//   final String botName;
//   final String botId;
//   late ChatBot chatBot;

//   BotPreviewPage({super.key, required this.botId, required this.botName});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       initialIndex: 1,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(botName),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Prompt'),
//               Tab(text: 'Preview'),
//               Tab(text: 'Knowledge'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             PromptTab(),
//             PreviewTab(),
//             KnowledgeTab(),
//           ],
//         ),
//       ),
//     );
//   }
// }
