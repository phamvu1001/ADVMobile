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
  bool  isHuman = true;
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

                bool current = isHuman;
                isHuman = !isHuman ;

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
                            color: Theme.of(context)
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
                            color: Theme.of(context).colorScheme.outline,
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
                      child: Text('GPT 4.0'),
                    ),
                    DropdownMenuItem<IconData>(
                      value: Icons.account_circle_sharp,
                      child: Text('Gemini'),
                    ),
                    DropdownMenuItem<IconData>(
                      value: Icons.ad_units_rounded,
                      child: Text('Claude AI '),
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
