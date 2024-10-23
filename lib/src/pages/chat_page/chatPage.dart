import 'package:flutter/material.dart';
import 'package:jarvis/src/navigation.dart';
import 'package:jarvis/src/pages/chat_page/conversationPage.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();

}

class _ChatPageState extends State<ChatPage> {


  void _goToConversation()
  {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ConversationPage()));  }
  List<ListTile> threads = [
    ListTile(
      leading: const CircleAvatar(),
      title: Text("Nguyen van a "),
    ),
    ListTile(
      leading: const CircleAvatar(),
      title: Text("Nguyen van b"),

    ),
    ListTile(
      leading: const CircleAvatar(),
      title: Text("Nguyen van c"),

    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children:threads.map((thread)
    {
      return ListTile(
        leading: thread.leading,
        title: thread.title,
        onTap: _goToConversation,
      );
    }).toList(),
    ));
  }
}
