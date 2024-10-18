import 'package:flutter/material.dart';
import 'package:jarvis/src/navigation.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> messages = [];
  final TextEditingController _controller = TextEditingController();
  String? selectedTool  = 'GPT 3.5';



  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  _toolAi(index)
  {
    //if (select)
  }

  void _handleHistoryBtn()

  {

  return;
}

void _uploadImage() {
  // Implement your upload image logic here
  return;
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        // Thread History
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.centerRight,
                child: ListTile(
                  trailing: const CircleAvatar(child: Icon(Icons.person)),
                  title: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      messages[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
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
                  child: TextButton.icon(onPressed:_toolAi(0) , icon: const Icon(Icons.ac_unit_outlined), label: const Text("GPT 3.5")),
                ),
                DropdownMenuItem<String>(
                  value: 'GPT 4.0',
                  child: TextButton.icon(onPressed:_toolAi(1) , icon: const Icon(Icons.ac_unit_outlined), label: const Text("GPT 4.0")),
                ),
                DropdownMenuItem<String>(
                  value: 'DALL·E',
                  child: TextButton.icon(onPressed:_toolAi(2) , icon: const Icon(Icons.ac_unit_outlined), label: const Text("Gemini")),
                ),
                DropdownMenuItem<String>(
                  value: 'Whisper',
                  child: TextButton.icon(onPressed:_toolAi(3) , icon: const Icon(Icons.ac_unit_outlined), label: const Text("Claude AI")),
                ),
              ],
            ),
            IconButton(onPressed: _handleHistoryBtn, icon: Icon(Icons.access_alarms_rounded))
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
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
              const SizedBox(width: 10),
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
    ),
  );
}}
