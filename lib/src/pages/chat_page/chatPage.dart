import 'package:flutter/material.dart';
import 'package:jarvis/main.dart';
import 'package:jarvis/src/constant/apiURL.dart';
import 'package:jarvis/src/models/chat/chat_thread.dart';
import 'package:jarvis/src/navigation.dart';
import 'package:jarvis/src/pages/chat_page/conversationPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jarvis/src/providers/authProvider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatThread> threads = [];

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _fetchConversations(authProvider.token);
  }

  Future<void> _fetchConversations(token) async {
    final response = await http.get(
      Uri.parse(APIURL.getConversations + '?assistantId=gpt-4o-mini&assistantModel=dify'),
      headers: {
        'Authorization': 'Bearer $token',
        'x-jarvis-guid': '361331f8-fc9b-4dfe-a3f7-6d9a1e8b289b',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List;

      setState(() {
        threads = items.map((item) {
          return ChatThread(
            id: item['id'] ?? '',
            title: item['title'] ?? 'No Title',
          );
        }).toList();
      });
    } else {
      // Handle error
      print('Failed to load conversations');
    }
  }

  void _goToConversation(conversationId, conversationTitle) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ConversationPage(conversationId: conversationId, conversationTitle: conversationTitle)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: threads.map((thread) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 8,
          ),
          title: Text(
            thread.title,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
          ),
          onTap: () => _goToConversation(thread.id, thread.title),
        );
      }).toList(),
    ));
  }
}
