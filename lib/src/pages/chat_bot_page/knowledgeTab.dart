import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jarvis/src/models/chat_bot/chat_bot.dart';
import 'package:jarvis/src/pages/knowledge_base_page/knowledgeBasePage.dart';
import 'package:jarvis/src/pages/personal_page/knowledgeTab.dart';
import 'package:jarvis/src/pages/personal_page/personalPage.dart';
import 'package:jarvis/src/routes.dart';

class KnowledgeTab extends StatefulWidget {
  final ChatBot chatbot;
  const KnowledgeTab({super.key, required this.chatbot});

  @override
  _KnowledgeTabState createState() => _KnowledgeTabState();
}

class _KnowledgeTabState extends State<KnowledgeTab> {
  final List<Map<String, dynamic>> _knowledgeList = [
    {
      'name': 'Knowledge 1',
      'units': 5,
      'size': '10 MB',
      'createdTime': '2023-10-01',
      'added': false,
    },
    {
      'name': 'Knowledge 2',
      'units': 3,
      'size': '5 MB',
      'createdTime': '2023-10-02',
      'added': false,
    },
    // Add more knowledge items as needed
  ];

  final List<Map<String, dynamic>> _addedKnowledgeList = [];

  final TextEditingController _searchController = TextEditingController();

  void _addKnowledge(Map<String, dynamic> knowledge) {
    setState(() {
      knowledge['added'] = true;
      _addedKnowledgeList.add(knowledge);
    });
  }

  void _removeKnowledge(Map<String, dynamic> knowledge) {
    setState(() {
      knowledge['added'] = false;
      _addedKnowledgeList.remove(knowledge);
    });
  }

  void _showAddKnowledgeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Knowledge'),
          content: SizedBox(
              width: MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search knowledge',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigate back to the knowledge creation tab
                      Navigator.pushNamed(
                          context, Routes.knowledge_page);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create Knowledge'),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: _knowledgeList.isEmpty
                        ? const Center(child: Text('No Knowledge Created'))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _knowledgeList.length,
                            itemBuilder: (context, index) {
                              final knowledge = _knowledgeList[index];
                              if (_searchController.text.isNotEmpty &&
                                  !knowledge['name'].toLowerCase().contains(
                                      _searchController.text.toLowerCase())) {
                                return Container();
                              }
                              return ListTile(
                                tileColor: index%2==0?Colors.blue.shade50:Colors.transparent,
                                leading: const Icon(HugeIcons.strokeRoundedDatabase),
                                title: Text(knowledge['name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Units: ${knowledge['units']}'),
                                    Text('Size: ${knowledge['size']}'),
                                    Text(
                                        'Created: ${knowledge['createdTime']}'),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    knowledge['added']
                                        ? Icons.remove
                                        : Icons.add,
                                    color: knowledge['added']
                                        ? Colors.red
                                        : Colors.blue,
                                  ),
                                  onPressed: () {
                                    if (knowledge['added']) {
                                      _removeKnowledge(knowledge);
                                    } else {
                                      _addKnowledge(knowledge);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            onPressed: _showAddKnowledgeDialog,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Add Knowledge',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.blue,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width < 600
                    ? MediaQuery.of(context).size.width
                    : 400.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 4.0,
                mainAxisExtent: 150.0,
              ),
              itemCount: _addedKnowledgeList.length,
              itemBuilder: (context, index) {
                final knowledge = _addedKnowledgeList[index];
                return Card(
                  color: Colors.blue.shade50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(HugeIcons.strokeRoundedDatabase),
                            const SizedBox(width: 8.0),
                            Text(
                              knowledge['name'],
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.remove, color: Colors.red,),
                                  onPressed: () {
                                    _removeKnowledge(knowledge);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text('Units: ${knowledge['units']}'),
                        Text('Size: ${knowledge['size']}'),
                        Text('Created: ${knowledge['createdTime']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
