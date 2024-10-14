
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BotsTab extends StatefulWidget {
  const BotsTab({super.key});

  @override
  _BotsTabState createState() => _BotsTabState();
}

class _BotsTabState extends State<BotsTab> {
  String _selectedType = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                        // Type choosing
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: DropdownButton<String>(
                            value: _selectedType,
                            items: <String>['All', 'Published', 'Favourite']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedType = newValue!;
                              });
                            },
                            underline: Container(),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Search field
                        Container(
                          width: 200,
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search bots',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                    const Spacer(),
                    
                    // Create bot button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle create bot action
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Create Bot'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: constraints.maxWidth < 600 ? constraints.maxWidth : 400.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 4.0,
                  mainAxisExtent: 150.0,
                ),
                itemCount: 5, // Replace with the actual number of bots
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.android), // Leading Icon
                              const SizedBox(width: 8.0), // Spacing
                              Expanded( // Allows text to take up remaining space
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Bot Name $index',
                                        style: Theme.of(context).textTheme.bodyLarge),
                                    Text(
                                      'Bot Description $index',
                                      style: Theme.of(context).textTheme.bodySmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {
                                  // Handle add to favourites action
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // Handle delete action
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [ 
                                const Spacer(),
                                Text(DateFormat('yyyy-MM-dd').format(DateTime.now())),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  );
                },
              );
            }
          ),
        ),
      ],
    );
  }
}