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


  void _newChat()
  {
    threads.add( ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.blue,),
      title: Text("I am going to have an interview, what should",maxLines: 1, overflow: TextOverflow.fade,),
    ));
  }
  void _goToConversation()
  {
    Navigator.push(context,MaterialPageRoute(builder: (context) => const ConversationPage()));  }
  List<ListTile> threads = [
    ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.blue,),
      title: Text("I am going to have an interview, what should",maxLines: 1, overflow: TextOverflow.fade,),
    ),
    ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.blue,),
      title: Text("I am going to have an interview, what should",maxLines: 1, overflow: TextOverflow.fade,),

    ),
    ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.blue,),
      title: Text("I am going to have an interview, what should",maxLines: 1, overflow: TextOverflow.fade,),
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
