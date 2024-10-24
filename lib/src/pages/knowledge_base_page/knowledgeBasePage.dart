import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jarvis/src/pages/personal_page/knowledgeDetails_page/knowledgeDetails.dart';
import 'package:jarvis/src/widgets/searchBar.dart';

class KnowledgeBasePage extends StatefulWidget {
  const KnowledgeBasePage({super.key});

  @override
  State<KnowledgeBasePage> createState() => _KnowledgeBasePage();
}

class _KnowledgeBasePage extends State<KnowledgeBasePage> {
  String _searchField = '';
  final TextEditingController _searchController = TextEditingController();

  final TextEditingController _knowledgeNameController =
  TextEditingController();
  final TextEditingController _knowledgeDescriptionController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            if (MediaQuery.of(context).size.width > 600) {
              return Row(
                children: [
                  Expanded(
                    child: CustomSearchBar(),
                  ),
                  const SizedBox(width: 16.0),
                  SizedBox(
                    height: 48.0,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle create knowledge action
                        _showCreateKnowledgeDialog(context);
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Create Knowledge',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor:Colors.blue,
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 13.0, 0.0),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search knowledge',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle create knowledge action
                        _showCreateKnowledgeDialog(context);
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Create Knowledge',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor:Colors.blue,
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 13.0, 0.0),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
          const SizedBox(height: 16.0),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool showAllColumn=constraints.maxWidth>600;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            headingTextStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                            columns: [
                              DataColumn(label: Text('Knowledge')),
                              DataColumn(label: Text('Units')),
                              if(showAllColumn) DataColumn(label: Text('Size')),
                              if(showAllColumn) DataColumn(label: Text('Edit Time')),
                              if(showAllColumn) DataColumn(label: Text('Action')),
                            ],
                            rows: List<DataRow>.generate(
                              10, // Replace with the actual number of knowledge items
                                  (index) => DataRow(
                                cells: [
                                  DataCell(
                                    MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onLongPress: ()=>{
                                            if(!showAllColumn){
                                              showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: Icon(Icons.delete),
                                                        title: Text('Delete'),
                                                        onTap: () {
                                                        },
                                                      ),
                                                      SizedBox(height: 30,)
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                            }
                                          },
                                          onTap: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    KnowledgeDetails(
                                                      knowledgeName:
                                                      'Knowledge Name $index',
                                                      units: 5,
                                                      size: '10 MB',
                                                    ),
                                              ),
                                            ),
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(HugeIcons.strokeRoundedDatabase),
                                              const SizedBox(width: 8.0),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text('Knowledge Name $index'),
                                                  Text(
                                                    'Knowledge Description $index',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  DataCell(Text(
                                      '5')), // Replace with actual units count
                                  if(showAllColumn) DataCell(Text(
                                      '10 MB')), // Replace with actual size
                                  if(showAllColumn) DataCell(Text(
                                      '2023-10-01')), // Replace with actual edit time
                                  if(showAllColumn) DataCell(
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        // Handle delete action
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateKnowledgeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create New Knowledge'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _knowledgeNameController,
                    decoration: InputDecoration(
                      hintText: 'Knowledge Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _knowledgeDescriptionController,
                    maxLines:
                    5, // Set the maxLines to a higher value for a larger text field
                    decoration: InputDecoration(
                      hintText: 'Knowledge Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
                ),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle create knowledge action
                  Navigator.of(context).pop();
                },
                child: const Text('Create'),
              ),
            ],
          );
        });
  }
}