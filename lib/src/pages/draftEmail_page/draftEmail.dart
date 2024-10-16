import 'package:flutter/material.dart';
import 'package:jarvis/src/navigation.dart';

class DraftEmailPage extends StatefulWidget {
  const DraftEmailPage({super.key, required this.title});

  final String title;

  @override
  State<DraftEmailPage> createState() => _DraftEmailPageState();
}

class _DraftEmailPageState extends State<DraftEmailPage> {
  final List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  IconData? selectedIcon = Icons.invert_colors_on_sharp;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
              TextButton(onPressed: () {print("thanks");}, child: Text("😀 Thanks")),
              TextButton(onPressed: () {print("thanks");}, child: Text("😔 Sorry")),
              TextButton(onPressed: () {print("thanks");}, child: Text("🐔 Alo alo")),
              TextButton(onPressed: () {print("thanks");}, child: Text(" For more info")),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [




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
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
                DropdownButton<IconData>(
                  value: selectedIcon,
                  onChanged: (IconData? newValue) {
                    setState(() {
                      selectedIcon = newValue;
                    });

                    if (newValue != null) {
                      print('Selected AI Tool: $newValue');
                    }
                  },
                  items: const [
                    DropdownMenuItem<IconData>(
                      value: Icons.invert_colors_on_sharp,
                      child: Text('GPT 3.5'),
                    ),
                    DropdownMenuItem<IconData>(
                      value: Icons.accessibility_rounded,
                      child: Text('GPT 3.5'),
                    ),
                    DropdownMenuItem<IconData>(
                      value: Icons.account_circle_sharp,
                      child: Text('GPT 3.5'),
                    ),
                    DropdownMenuItem<IconData>(
                      value: Icons.ad_units_rounded,
                      child: Text('GPT 3.5'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
