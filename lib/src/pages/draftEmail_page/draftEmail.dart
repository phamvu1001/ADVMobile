import 'package:flutter/material.dart';
import 'package:jarvis/src/navigation.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  bool isHuman = true;
  String? _selectedChoice = "Sorry";

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
    List<Map<String, IconData>> menuitems = const [
      {'GPT 3.5': Icons.invert_colors_on_sharp},
      {'GPT 4.0': Icons.accessibility_rounded},
      {'Gemini': Icons.account_circle_sharp},
      {'Claude AI': Icons.ad_units_rounded}
    ];
    final List<Map<String, String>> options = [
      {"label": "Thanks", "emoji": "😀"},
      {"label": "Sorry", "emoji": "😀"},
      {"label": "...", "emoji": "😀"},
      {"label": "Thank you", "emoji": "😀"},
      {"label": "Welcome", "emoji": "😀"},
      {"label": "Goodbye", "emoji": "😀"},
    ];
    return Scaffold(
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

                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(

                                messages[index],
                                style: const TextStyle(color: Colors.white ),
                              ),
                            ),
                          ),
                        ));
              },
            ),
          ),
          const Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: options.map((option) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterChip(

                    avatar: Text(option['emoji']!),
                    label: Text(option['label']!),
                    selected: _selectedChoice == option['label'],
                    selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    showCheckmark: false,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedChoice = selected ? option['label'] : null;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
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
                IntrinsicWidth(
                  child: DropdownButtonFormField2<IconData>(
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
                    value: selectedIcon,
                    hint: const Text(
                      'Select Tool',
                      style: TextStyle(fontSize: 11),
                    ),
                    items: menuitems.map((entry) {
                      final IconData value = entry.values.first;
                      final String key = entry.keys.first;

                      return DropdownMenuItem<IconData>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(value , color: Colors.blue) ,
                            Text(key, style: const TextStyle(fontSize: 14, color: Colors.blue)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedIcon = value!;
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
