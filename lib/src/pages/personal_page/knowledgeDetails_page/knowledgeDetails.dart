import 'package:flutter/material.dart';

class KnowledgeDetails extends StatelessWidget {
  final String knowledgeName;
  final int units;
  final String size;

  const KnowledgeDetails({
    Key? key,
    required this.knowledgeName,
    required this.units,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(knowledgeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      knowledgeName,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text('Units: $units'),
                    Text('Size: $size'),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle add unit action
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Add unit',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    backgroundColor: const Color.fromARGB(255, 58, 183, 129),
                    padding: const EdgeInsets.fromLTRB(8.0, 20.0, 13.0, 20.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                      child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Unit')),
                      DataColumn(label: Text('Source')),
                      DataColumn(label: Text('Size')),
                      DataColumn(label: Text('Create Time')),
                      DataColumn(label: Text('Latest Update')),
                      DataColumn(label: Text('Enable')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: List<DataRow>.generate(
                      10, // Replace with the actual number of units
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            Row(
                              children: [
                                const Icon(Icons.insert_drive_file),
                                const SizedBox(width: 8.0),
                                Text('Unit Name $index.pdf'),
                              ],
                            ),
                          ),
                          DataCell(
                              Text('Local file')), // Replace with actual source
                          DataCell(Text('2 MB')), // Replace with actual size
                          DataCell(Text(
                              '2023-10-01')), // Replace with actual create time
                          DataCell(Text(
                              '2023-10-02')), // Replace with actual latest update
                          DataCell(
                            Switch(
                              value: true, // Replace with actual enable state
                              onChanged: (bool value) {
                                // Handle enable/disable action
                                 
                              },
                            ),
                          ),
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
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
