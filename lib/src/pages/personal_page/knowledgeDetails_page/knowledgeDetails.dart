import 'package:flutter/material.dart';

class KnowledgeDetails extends StatefulWidget {
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
  _KnowledgeDetailsState createState() => _KnowledgeDetailsState();
}

class _KnowledgeDetailsState extends State<KnowledgeDetails> {
  String? _selectedSource;
  bool _showFields = false;

  void _showAddUnitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Unit'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_showFields)
                    Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.insert_drive_file),
                          title: const Text('Local files'),
                          onTap: () {
                            setState(() {
                              _selectedSource = 'Local files';
                            });
                          },
                          selected: _selectedSource == 'Local files',
                        ),
                        ListTile(
                          leading: const Icon(Icons.web),
                          title: const Text('Website'),
                          onTap: () {
                            setState(() {
                              _selectedSource = 'Website';
                            });
                          },
                          selected: _selectedSource == 'Website',
                        ),
                        // Add more ListTile widgets for other sources
                      ],
                    ),
                  if (_showFields && _selectedSource == 'Local files')
                    Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'File Path',
                          ),
                        ),
                        // Add more fields for local files if needed
                      ],
                    ),
                  if (_showFields && _selectedSource == 'Website')
                    Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'URL',
                          ),
                        ),
                        // Add more fields for website if needed
                      ],
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _showFields = false;
                    });
                  },
                  child: const Text('Cancel'),
                ),
                if (!_showFields)
                  ElevatedButton(
                    onPressed: _selectedSource != null
                        ? () {
                            setState(() {
                              _showFields = true;
                            });
                          }
                        : null,
                    child: const Text('Next'),
                  ),
                if (_showFields)
                  ElevatedButton(
                    onPressed: () {
                      // Handle add unit action
                      Navigator.of(context).pop();
                      setState(() {
                        _showFields = false;
                      });
                    },
                    child: const Text('Add'),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.knowledgeName),
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
                      widget.knowledgeName,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text('Units: ${widget.units}'),
                    Text('Size: ${widget.size}'),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle add unit action
                    _showAddUnitDialog();
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
