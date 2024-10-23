import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _conversationPage();
}

class _conversationPage extends State<ConversationPage> {
  final List<String> messages = [];
  final TextEditingController _controller = TextEditingController();
  String? selectedTool = 'GPT 3.5';
  bool isHuman = true;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
        _controller.clear();
      });
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
    return Scaffold(
        appBar: AppBar(
            title: const Text('Nguyen Van a')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool current = isHuman;
                  isHuman = !isHuman;

                  return current
                      ? Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: ListTile(
                          horizontalTitleGap: 5,
                          trailing:
                          const CircleAvatar(child: Icon(Icons.person)),
                          title: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color:
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .inversePrimary,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              messages[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ))
                      : Align(
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
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .outline,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              messages[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ),

            const Divider(),
            Row(
              children: [
                DropdownButton<String>(
                  value: selectedTool,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTool = newValue;
                    });

                    if (newValue != null) {
                      print('Selected AI Tool: $newValue');
                    }
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'GPT 3.5',
                      child: TextButton.icon(
                          onPressed: _toolAi(0),
                          icon: const Icon(Icons.ac_unit_outlined),
                          label: const Text("GPT 3.5")),
                    ),
                    DropdownMenuItem<String>(
                      value: 'GPT 4.0',
                      child: TextButton.icon(
                          onPressed: _toolAi(1),
                          icon: const Icon(Icons.ac_unit_outlined),
                          label: const Text("GPT 4.0")),
                    ),
                    DropdownMenuItem<String>(
                      value: 'DALL·E',
                      child: TextButton.icon(
                          onPressed: _toolAi(2),
                          icon: const Icon(Icons.ac_unit_outlined),
                          label: const Text("Gemini")),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Whisper',
                      child: TextButton.icon(
                          onPressed: _toolAi(3),
                          icon: const Icon(Icons.ac_unit_outlined),
                          label: const Text("Claude AI")),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: _handleHistoryBtn,
                  icon: const Icon(Icons.access_alarms_rounded),
                  tooltip: "History",
                ),
              ],
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  // Send Button
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: _uploadImage,
                  ),
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: _uploadImage,
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
