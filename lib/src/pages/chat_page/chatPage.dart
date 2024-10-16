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
  String? selectedTool = 'GPT 4.0'; // Giá trị mặc định

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
        _controller.clear();
      });
    }
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
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(messages[index]),
              );
            },
          ),
        ),

        const Divider(),
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.ac_unit)),
                title: const Text("GPT 4.0"),
              ),
            ),
            DropdownButton<String>(
              value: selectedTool,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTool = newValue; // Cập nhật giá trị đã chọn
                });
                // Xử lý khi chọn tool AI
                if (newValue != null) {
                  print('Selected AI Tool: $newValue');
                }
              },
              items: const [
                DropdownMenuItem<String>(
                  value: 'GPT 3.5',
                  child: Text('GPT 3.5'),
                ),
                DropdownMenuItem<String>(
                  value: 'GPT 4.0',
                  child: Text('GPT 4.0'),
                ),
                DropdownMenuItem<String>(
                  value: 'DALL·E',
                  child: Text('DALL·E'),
                ),
                DropdownMenuItem<String>(
                  value: 'Whisper',
                  child: Text('Whisper'),
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
