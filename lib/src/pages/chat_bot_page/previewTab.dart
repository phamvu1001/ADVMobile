import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jarvis/src/builders/scrollableCodeBlockBuilder.dart';
import 'package:jarvis/src/models/chat_bot/chat_bot.dart';
import 'package:jarvis/src/models/chat_bot/thread_message.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/services/chatBotServices.dart';
import 'package:jarvis/src/widgets/TypingIndicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviewTab extends StatefulWidget {
  final ChatBot chatBot;

  const PreviewTab({Key? key, required this.chatBot}) : super(key: key);

  @override
  _PreviewTabState createState() => _PreviewTabState();
}

class _PreviewTabState extends State<PreviewTab> {
  final List<Map<String, String>> _messages = [];
  List<ThreadMessage> _threadMessages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    fetchThreadMessages(authProvider);
  }

  Future<void> fetchThreadMessages(AuthProvider authProvider) async {
    final data = await ChatBotServices().getMessagesOfThread(
        kbToken: authProvider.knowledgeBaseToken!,
        openAiThreadIdPlay: widget.chatBot.openAiThreadIdPlay);

    if (data.isNotEmpty) {
      final items = data as List;
      final int length = items.length;
      print('Length: $length');

      for (int i = length - 1; i >= 0; i--) {
        String role = items[i]['role'];
        String content = items[i]['content'][0]['text']['value'];
        DateTime createdAt = DateTime.parse(items[i]['createdAt'].toString());

        setState(() {
          _threadMessages.add(ThreadMessage(
              content: content,
              role: role,
              createdAt: createdAt));
        });
      }
    }

    _scrollToBottom();
  }

  Future<void> sendMessage(AuthProvider authProvider) async {
    String message = _messageController.text;
    _messageController.clear();
    if (message.isEmpty) return;

    setState(() {
      _threadMessages.add(ThreadMessage(
          role: 'user', content: message, createdAt: DateTime.now()));
      _threadMessages.add(ThreadMessage(
          content: '...', role: 'assistant', createdAt: DateTime.now()));
    });

    final data = await ChatBotServices().chatWithBot(
        kbToken: authProvider.knowledgeBaseToken!,
        openAiThreadIdPlay: widget.chatBot.openAiThreadIdPlay,
        message: message,
        assistantId: widget.chatBot.id,
        additionalInstructions: widget.chatBot.instructions);

    if (data != '') {
      final item = ThreadMessage(
          content: data, role: 'assistant', createdAt: DateTime.now());
      setState(() {
        _threadMessages.last = item;
      });
    } else {
      setState(() {
        _threadMessages.last = ThreadMessage(
            content: 'Failed to get a response. Please try again.',
            role: 'assistant',
            createdAt: DateTime.now());
      });
    }

    _scrollToBottom();
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: _threadMessages.length,
            itemBuilder: (context, index) {
              final message = _threadMessages[index];
              final isUser = message.role == 'user';

              return isUser
                  ? Column(
                      children: [
                        Align(
                            alignment: isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
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
                                          color: Color.fromARGB(
                                              255, 235, 235, 235),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          message.content,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      )),
                                  const SizedBox(width: 10),
                                  const CircleAvatar(
                                    child: Icon(Icons.person),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(height: 12),
                      ],
                    )
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.android)),
                                const SizedBox(width: 10),
                                Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: message.content == '...'
                                              ? Colors.transparent
                                              : Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: message.content == '...'
                                            ? Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [TypingIndicator()],
                                              )
                                            : MarkdownBody(
                                                data: message.content,
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16)),
                                                builders: {
                                                  'codeblock':
                                                      ScrollableCodeblockbuilder(
                                                          codeStyle: GoogleFonts
                                                              .firaCode(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      16)),
                                                },
                                                selectable: true,
                                                onTapLink:
                                                    (text, href, title) async {
                                                  if (href != null) {
                                                    final Uri url =
                                                        Uri.parse(href);
                                                    if (await canLaunchUrl(
                                                        url)) {
                                                      await launchUrl(url,
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    } else {
                                                      print(
                                                          'Could not launch $url');
                                                    }
                                                  }
                                                },
                                              )))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
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
                  // onSubmitted: (value) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8.0),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async => await sendMessage(authProvider),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
