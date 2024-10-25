import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/knowledge_base_page/dataUnitDialog.dart';

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
                          selectedColor: Colors.blue,
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
                          selectedColor: Colors.blue,
                          leading: const Icon(Icons.web),
                          title: const Text('Website'),
                          onTap: () {
                            setState(() {
                              _selectedSource = 'Website';
                            });
                          },
                          selected: _selectedSource == 'Website',
                        ),
                        ListTile(
                          selectedColor: Colors.blue,
                          leading: const Icon(Icons.drive_folder_upload),
                          title: const Text('Google Drive'),
                          onTap: () {
                            setState(() {
                              _selectedSource = 'Google Drive';
                            });
                          },
                          selected: _selectedSource == 'Google Drive',
                        ),
                        ListTile(
                          selectedColor: Colors.blue,
                          leading: const Icon(Icons.chat),
                          title: const Text('Slack'),
                          onTap: () {
                            setState(() {
                              _selectedSource = 'Slack';
                            });
                          },
                          selected: _selectedSource == 'Slack',
                        ),
                        ListTile(
                          selectedColor: Colors.blue,
                          leading: const Icon(Icons.book),
                          title: const Text('Confluence'),
                          onTap: () {
                            setState(() {
                              _selectedSource = 'Confluence';
                            });
                          },
                          selected: _selectedSource == 'Confluence',
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
                  if (_showFields && _selectedSource == 'Google Drive')
                    Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Google Drive Credential',
                          ),
                        ),
                        // Add more fields for Google Drive if needed
                      ],
                    ),
                  if (_showFields && _selectedSource == 'Slack')
                    Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Slack Workspace',
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Slack Bot Token',
                          ),
                        ),
                        // Add more fields for Slack if needed
                      ],
                    ),
                  if (_showFields && _selectedSource == 'Confluence')
                    Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Wiki Page URL',
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Confluence Username',
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Confluence Access Token',
                          ),
                        ),
                        // Add more fields for Confluence if needed
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
                SizedBox(
                  child: ElevatedButton.icon(
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
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.blue,
                    ),
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
                        headingTextStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                        columns: [
                          DataColumn(label: Text('Unit')),
                          if(MediaQuery.of(context).size.width>600) DataColumn(label: Text('Source')),
                          if(MediaQuery.of(context).size.width>600)DataColumn(label: Text('Size')),
                          if(MediaQuery.of(context).size.width>600) DataColumn(label: Text('Create Time')),
                          if(MediaQuery.of(context).size.width>600) DataColumn(label: Text('Latest Update')),
                          DataColumn(label: Text('Enable')),
                          if(MediaQuery.of(context).size.width>600) DataColumn(label: Text('Action')),
                        ],
                        rows: List<DataRow>.generate(
                          10, // Replace with the actual number of units
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                GestureDetector(
                                  onTap: ()=> {
                                    if(MediaQuery.of(context).size.width<600){
                                      showDialog(context: context, builder: (context) =>DataUnitDialog())
                                    }
                                  },
                                  onLongPress: ()=>{
                                    if(MediaQuery.of(context).size.width<600){
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
                                  child: Row(
                                    children: [
                                      const Icon(Icons.insert_drive_file),
                                      const SizedBox(width: 8.0),
                                      Text('Unit Name $index.pdf'),
                                    ],
                                  ),
                                ),
                              ),
                              if(MediaQuery.of(context).size.width>600) DataCell(
                                  Text('Local file')), // Replace with actual source
                              if(MediaQuery.of(context).size.width>600) DataCell(Text('2 MB')), // Replace with actual size
                              if(MediaQuery.of(context).size.width>600) DataCell(Text(
                                  '2023-10-01')), // Replace with actual create time
                              if(MediaQuery.of(context).size.width>600) DataCell(Text(
                                  '2023-10-02')), // Replace with actual latest update
                              DataCell(
                                Switch(
                                  activeTrackColor: Colors.blue,
                                  value: true, // Replace with actual enable state
                                  onChanged: (bool value) {
                                    // Handle enable/disable action

                                  },
                                ),
                              ),
                              if(MediaQuery.of(context).size.width>600) DataCell(
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
