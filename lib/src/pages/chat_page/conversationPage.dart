import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jarvis/src/builders/scrollableCodeBlockBuilder.dart';
import 'package:jarvis/src/constant/apiURL.dart';
import 'package:jarvis/src/models/chat/assistant_model.dart';
import 'package:http/http.dart' as http;
import 'package:jarvis/src/models/chat/conversation.dart';
import 'package:jarvis/src/models/chat/conversation_item.dart';
import 'package:jarvis/src/pages/chat_page/suggestPromptList.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/routes.dart';
import 'package:jarvis/src/widgets/TypingIndicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  int _remaingUsage = 50;
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

  Map<String, Widget> assistantIcons = {
    'claude-3-haiku-20240307': ClipOval(
        child: Image.asset('assets/claude_3_haiku.png',
            width: 30, height: 30, fit: BoxFit.cover)),
    'claude-3-sonnet-20240229': ClipOval(
        child: Image.asset('assets/claude_3_haiku.png',
            width: 30, height: 30, fit: BoxFit.cover)),
    'gemini-1.5-flash-latest': ClipOval(
        child: Image.asset('assets/gemini.png',
            width: 30, height: 30, fit: BoxFit.cover)),
    'gemini-1.5-pro-latest': ClipOval(
        child: Image.asset('assets/gemini_15_pro.png',
            width: 30, height: 30, fit: BoxFit.cover)),
    'gpt-4o': ClipOval(
        child: Image.asset('assets/gpt-4.webp',
            width: 30, height: 30, fit: BoxFit.cover)),
    'gpt-4o-mini': ClipOval(
        child: Image.asset('assets/gpt_4o_mini.jpg',
            width: 30, height: 30, fit: BoxFit.cover)),
  };

  List<Map<Assistant, Widget>> menuItems = [
    {
      Assistant(id: 'claude-3-haiku-20240307', name: 'Claude 3 Haiku'):
          ClipOval(
              child: Image.asset('assets/claude_3_haiku.png',
                  width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'claude-3-sonnet-20240229', name: 'Claude 3.5 Sonnet'):
          ClipOval(
              child: Image.asset('assets/claude_3_haiku.png',
                  width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'gemini-1.5-flash-latest', name: 'Gemini 1.5 Flash'):
          ClipOval(
              child: Image.asset('assets/gemini.png',
                  width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'gemini-1.5-pro-latest', name: 'Gemini 1.5 Pro'): ClipOval(
          child: Image.asset('assets/gemini_15_pro.png',
              width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'gpt-4o', name: 'GPT-4o'): ClipOval(
          child: Image.asset('assets/gpt-4.webp',
              width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'gpt-4o-mini', name: 'GPT-4o mini'): ClipOval(
          child: Image.asset('assets/gpt_4o_mini.jpg',
              width: 30, height: 30, fit: BoxFit.cover)),
    },
  ];
  final List<String> messages = [];
  List<ConversationItem> conversationItems = [];
  final TextEditingController _controller = TextEditingController();
  String? selectedTool = 'GPT 3.5';
  bool isHuman = true;
  bool isShowPrompt = false; //pvu
  String queryPromt = ""; //pvu

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    fetchConversationHistory(
        widget.conversationId, _selectedAssistantId, authProvider.token);

    fetchAvailableToken(authProvider.token);
  }

  Future<void> fetchAvailableToken(token) async {
    final response = await http.get(
      Uri.parse(APIURL.getUsage),
      headers: {
        'Authorization': 'Bearer $token',
        'x-jarvis-guid': '361331f8-fc9b-4dfe-a3f7-6d9a1e8b289b',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _remaingUsage = data['availableTokens'] as int;
      });
    }
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

    _scrollToBottom();
  }

  // Send api request to chat with assistant
  Future<void> _sendMessage(token) async {
    if (_controller.text.isNotEmpty) {
      print(_controller.text);
      print(token);

      setState(() {
        conversation.messages.add(Message(
          role: 'user',
          content: _controller.text,
          assistant: assistants[_selectedAssistantId]!,
        ));

        conversationItems.add(ConversationItem(
          query: _controller.text,
          answer: '...',
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ));
      });

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
              role: 'model',
              content: data['message'],
              assistant: assistants[_selectedAssistantId]!));

          conversationItems.last = ConversationItem(
            query: _controller.text,
            answer: data['message'] as String,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          );

          _remaingUsage = data['remainingUsage'] as int;
        });
      } else {
        // Handle error
        setState(() {
          conversationItems.last = ConversationItem(
            query: _controller.text,
            answer: 'Failed to get a response. Please try again.',
            createdAt: DateTime.now().millisecondsSinceEpoch,
          );
        });
        print('Failed to send message');
      }

      _controller.clear();
    }
  }

  _toolAi(index) {}

  void _handleHistoryBtn() {
    Navigator.pushNamed(context, Routes.chat);
  }

  void _uploadImage() {
    return;
  }

  //pvu
  void onTextChange(String value) {
    if ((value.endsWith(" ") || value.isEmpty) && isShowPrompt) {
      setState(() {
        isShowPrompt = false;
      });
      return;
    }
    if (value.lastIndexOf("/") > value.lastIndexOf(" ") &&
        value.lastIndexOf("/") > value.lastIndexOf("  ") &&
        value.lastIndexOf("/") > value.lastIndexOf('\n') &&
        value.contains("/")) {
      setState(() {
        isShowPrompt = true;
      });
      queryPromt = value.substring(value.lastIndexOf("/") + 1);
    }
  }

  void onSuggestSelected(String prompt) {
    _controller.text =
        _controller.text.substring(0, _controller.text.lastIndexOf("/"));
    _controller.text += prompt;
    setState(() {
      isShowPrompt = false;
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? data =
        ModalRoute.of(context)!.settings.arguments as String?; //pvu
    if (data != null) {
      _controller.text += data;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.conversationTitle == ''
                ? 'New Chat'
                : widget.conversationTitle,
            overflow: TextOverflow.fade,
          ),
          actions: [
            Row(children: [
              Text(
                '$_remaingUsage',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Image.asset(
                'assets/fire-icon.png',
                height: 25,
                width: 25,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConversationPage()));
                  },
                  icon: Icon(Icons.add))
            ])
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: conversationItems.length,
                itemBuilder: (context, index) {
                  final item = conversationItems[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index > 0) const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                  fit: FlexFit.loose,
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 235, 235, 235),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text(
                                      conversationItems[index].query,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  )),
                              const SizedBox(width: 10),
                              const CircleAvatar(
                                child: Icon(Icons.person),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: assistantIcons[_selectedAssistantId]),
                              const SizedBox(width: 10),
                              Flexible(
                                  fit: FlexFit.loose,
                                  child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: item.answer == '...'
                                            ? Colors.transparent
                                            : Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: item.answer == '...'
                                          ? Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [TypingIndicator()],
                                            )
                                          : MarkdownBody(
                                              data: conversationItems[index]
                                                  .answer,
                                              styleSheet: MarkdownStyleSheet(
                                                p: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                                h1: const TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white),
                                                h2: const TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.white),
                                                strong: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                em: const TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                                blockquote: const TextStyle(
                                                    color: Colors.white70),
                                                code: GoogleFonts.firaCode(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                                )
                                              ),
                                              builders: {
                                                'codeblock': ScrollableCodeblockbuilder(
                                                  codeStyle: GoogleFonts.firaCode(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16
                                                  )
                                                ),
                                              },
                                              selectable: true,
                                              onTapLink: (text, href, title) async {
                                                if (href != null) {
                                                  final Uri url = Uri.parse(href);
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(
                                                      url,
                                                      mode: LaunchMode.externalApplication
                                                    );
                                                  } else {
                                                    print('Could not launch $url');
                                                  }
                                                }
                                              },
                                            )))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(),
            if (!isShowPrompt)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IntrinsicWidth(
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          isDense: false,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        value: _selectedAssistantId,
                        hint: const Text(
                          'Select Tool',
                          style: TextStyle(fontSize: 11),
                        ),
                        items: menuItems.map((entry) {
                          final Assistant key = entry.keys.first;
                          final Widget icon = entry.values.first;

                          return DropdownMenuItem<String>(
                            value: key.id, // Use the key as the value
                            child: Row(
                              children: [
                                ClipOval(
                                    child: SizedBox(
                                        width: 30, height: 30, child: icon)),
                                const SizedBox(width: 10),
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
                        selectedItemBuilder: (BuildContext context) {
                          return menuItems.map((entry) {
                            final Assistant key = entry.keys.first;
                            final Widget icon = entry.values.first;

                            return Row(
                              children: [
                                ClipOval(
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: icon,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  key.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            );
                          }).toList();
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
            if (isShowPrompt)
              SuggestPromptList(
                onSelectedItem: onSuggestSelected,
                queryPrompt: queryPromt,
                accessToken: authProvider.token!,
              ),
            // Input Field and Send Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Input field
                  Expanded(
                    child: TextField(
                      onChanged: (value) =>
                          onTextChange(value.toString()), //pvu
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
                    onPressed: () async =>
                        await _sendMessage(authProvider.token),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
