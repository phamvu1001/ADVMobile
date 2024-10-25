import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/chat_bot_page/previewTab.dart';
import 'package:jarvis/src/pages/chat_bot_page/promptTab.dart';
import 'package:jarvis/src/pages/chat_bot_page/knowledgeTab.dart';

class BotPreviewPage extends StatelessWidget {
  final String botName;

  const BotPreviewPage({Key? key, required this.botName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(botName),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Prompt'),
              Tab(text: 'Preview'),
              Tab(text: 'Knowledge'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PromptTab(),
            PreviewTab(),
            KnowledgeTab(),
          ],
        ),
      ),
    );
  }
}
