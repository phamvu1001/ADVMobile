import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:jarvis/src/constant/apiURL.dart';
import 'package:jarvis/src/models/chat/assistant_model.dart';
import 'package:http/http.dart' as http;
import 'package:jarvis/src/models/chat/conversation.dart';
import 'package:jarvis/src/models/chat/conversation_item.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage(
      {Key? key, this.conversationId = '', this.conversationTitle = ''})
      : super(key: key);

  final String conversationId;
  final String conversationTitle;

  @override
  State<ConversationPage> createState() => _conversationPage();
}

class _conversationPage extends State<ConversationPage> {
  Conversation conversation = Conversation(id: '', messages: []);
  String _selectedAssistantId = 'gpt-4o-mini';
  Map<String, Assistant> assistants = {
    'gpt-4o-mini': Assistant(id: 'gpt-4o-mini', name: 'GPT-4o mini'),
    'gpt-4o': Assistant(id: 'gpt-4o', name: 'GPT-4o'),
    'gemini-1.5-pro-latest':
        Assistant(id: 'gemini-1.5-pro-latest', name: 'Gemini 1.5 Pro'),
    'gemini-1.5-flash-latest':
        Assistant(id: 'gemini-1.5-flash-latest', name: 'Gemini 1.5 Flash'),
    'claude-3-sonnet-20240229':
        Assistant(id: 'claude-3-sonnet-20240229', name: 'Claude 3.5 Sonnet'),
    'claude-3-haiku-20240307':
        Assistant(id: 'claude-3-haiku-20240307', name: 'Claude 3 Haiku')
  };

  List<Map<Assistant, Icon>> menuItems = [
    {
      Assistant(id: 'claude-3-haiku-20240307', name: 'Claude 3 Haiku'):
          const Icon(
        Icons.ac_unit_outlined,
        color: Colors.blue,
      ),
    },
    {
      Assistant(id: 'claude-3-sonnet-20240229', name: 'Claude 3.5 Sonnet'):
          const Icon(Icons.ac_unit_outlined, color: Colors.blue),
    },
    {
      Assistant(id: 'gemini-1.5-flash-latest', name: 'Gemini 1.5 Flash'):
          const Icon(Icons.ac_unit_outlined, color: Colors.blue),
    },
    {
      Assistant(id: 'gemini-1.5-pro-latest', name: 'Gemini 1.5 Pro'):
          const Icon(Icons.ac_unit_outlined, color: Colors.blue),
    },
    {
      Assistant(id: 'gpt-4o', name: 'GPT-4o'):
          const Icon(Icons.ac_unit_outlined, color: Colors.blue),
    },
    {
      Assistant(id: 'gpt-4o-mini', name: 'GPT-4o mini'):
          const Icon(Icons.ac_unit_outlined, color: Colors.blue),
    },
  ];
  final List<String> messages = [];
  List<ConversationItem> conversationItems = [];
  final TextEditingController _controller = TextEditingController();
  String? selectedTool = 'GPT 3.5';
  bool isHuman = true;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    fetchConversationHistory(
        widget.conversationId, _selectedAssistantId, authProvider.token);
  }

  Future<void> fetchConversationHistory(
      conversationId, assistantId, token) async {
    if (conversationId == '') {
      return;
    }

    final response = await http.get(
      Uri.parse(APIURL.getConversationHistory(conversationId) +
          '?assistantId=$assistantId&assistantModel=dify'),
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
        conversation.id = conversationId ?? '';
        conversationItems = items.map((item) {
          conversation.messages.add(Message(
              role: 'user',
              content: item['query'],
              assistant: assistants[_selectedAssistantId]!));
          conversation.messages.add(Message(
              role: 'model',
              content: item['answer'],
              assistant: assistants[_selectedAssistantId]!));

          return ConversationItem(
            query: item['query'] ?? '',
            answer: item['answer'] ?? '',
            createdAt: item['createdAt'] ?? '',
            files: (item['files'] as List<dynamic>).cast<String>() ?? [],
          );
        }).toList();

        print(conversationItems.length);
        for (var item in conversationItems) {
          print(item.query);
          print(item.answer);
        }

      });
    } else {
      // Handle error
      print('Failed to load conversation history');
    }
  }

  // Send api request to chat with assistant
  Future<void> _sendMessage(token) async {
    if (_controller.text.isNotEmpty) {
      print(_controller.text);
      print(token);
      final response = await http.post(
        Uri.parse(APIURL.sendMessage),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'content': _controller.text,
          'metadata': {'conversation': conversation.toJson()},
          'assistant': assistants[_selectedAssistantId]!.toJson(),
        }),
      );

      print(json.encode(assistants[_selectedAssistantId]!.toJson()));
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          conversation.id = data['conversationId'] as String;

          conversation.messages.add(Message(
              role: 'user',
              content: _controller.text,
              assistant: assistants[_selectedAssistantId]!));
          conversation.messages.add(Message(
              role: 'model',
              content: data['message'],
              assistant: assistants[_selectedAssistantId]!));

          conversationItems.add(ConversationItem(
              query: _controller.text,
              answer: data['message'] as String,
              createdAt: DateTime.now().millisecondsSinceEpoch));
          _controller.clear();
        });
      } else {
        // Handle error
        print('Failed to send message');
      }
    }
  }

  _toolAi(index) {}

  void _handleHistoryBtn() {
    return;
  }

  void _uploadImage() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.conversationTitle,
            overflow: TextOverflow.fade,
          ),
          actions: [
            Row(children: [
              Text(
                "25",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Image.asset(
                'assets/fire-icon.png',
                height: 25,
                width: 25,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.add))
            ])
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: conversationItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: ListTile(
                            horizontalTitleGap: 5,
                            trailing: const CircleAvatar(child: Icon(Icons.person)),
                            title: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 235, 235, 235),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                conversationItems[index].query,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: ListTile(
                            horizontalTitleGap: 5,
                            leading: const CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                )),
                            title: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                conversationItems[index].answer,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IntrinsicWidth(
                    child: DropdownButtonFormField2<String>(
                      isExpanded: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      )),
                      value: _selectedAssistantId,
                      hint: const Text(
                        'Select Tool',
                        style: TextStyle(fontSize: 11),
                      ),
                      items: menuItems.map((entry) {
                        final Assistant key = entry.keys.first;
                        final Icon icon = entry.values.first;

                        return DropdownMenuItem<String>(
                          value: key.id, // Use the key as the value
                          child: Row(
                            children: [
                              icon,
                              Text(key.name,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.blue)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedAssistantId = value!;
                        });
                      },
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _handleHistoryBtn,
                    icon: const Icon(Icons.access_alarms_rounded),
                    tooltip: "History",
                  ),
                ],
              ),
            ),
            // Input Field and Send Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Input field
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  // Send Button
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: _uploadImage,
                    color: Colors.blue,
                  ),
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: _uploadImage,
                    color: Colors.blue,
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async => await _sendMessage(authProvider.token),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
