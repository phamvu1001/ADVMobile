import 'dart:ui';

import 'package:flutter/material.dart';

class KnowledgeTab extends StatefulWidget {
  const KnowledgeTab({super.key});

  @override
  _KnowledgeTabState createState() => _KnowledgeTabState();
}

class _KnowledgeTabState extends State<KnowledgeTab> {
  String _searchField = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Row(
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
              const SizedBox(width: 16.0),
              SizedBox(
                height: 48.0,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle create knowledge action
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Create Knowledge',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    backgroundColor: const Color.fromARGB(255, 58, 183, 129),
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 13.0, 0.0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Knowledge')),
                  DataColumn(label: Text('Units')),
                  DataColumn(label: Text('Size')),
                  DataColumn(label: Text('Edit Time')),
                  DataColumn(label: Text('Action')),
                ],
                rows: List<DataRow>.generate(
                  10, // Replace with the actual number of knowledge items
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            const Icon(Icons.book),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                      ),
                      DataCell(Text('5')), // Replace with actual units count
                      DataCell(Text('10 MB')), // Replace with actual size
                      DataCell(
                          Text('2023-10-01')), // Replace with actual edit time
                      DataCell(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
