import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
    String _selectedTool = 'GPT 3.5';
    List<Map<String, Icon>> menuItems = [
      {
        'GPT 3.5': const Icon(Icons.ac_unit_outlined, color: Colors.blue,),
      },
      {
        'GPT 4.0': const Icon(Icons.ac_unit_outlined, color: Colors.blue),
      },
      {
        'DALL·E': const Icon(Icons.ac_unit_outlined, color: Colors.blue),
      },
      {
        'Whisper': const Icon(Icons.ac_unit_outlined, color: Colors.blue),
      },
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Nguyen Van a'),
          actions: [
            Row(children: [
              Text(
                "25",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Image.asset(
                'lib/assets/fire-icon.png',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IntrinsicWidth(
                    child: DropdownButtonFormField2<String>(
                      isExpanded: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      )),
                      value: _selectedTool,
                      hint: const Text(
                        'Select Tool',
                        style: TextStyle(fontSize: 11),
                      ),
                      items: menuItems.map((entry) {
                        final String key = entry.keys.first;
                        final Icon icon = entry.values.first;

                        return DropdownMenuItem<String>(
                          value: key, // Use the key as the value
                          child:
                          Row(
                            children: [
                                  icon,
                                  Text(key, style: const TextStyle(fontSize: 14, color: Colors.blue)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTool = value!;
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
