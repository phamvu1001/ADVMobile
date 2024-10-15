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
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                children: [
                  IntrinsicWidth(
                    child: DropdownButtonFormField<String>(
                      isExpanded: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                      )),
                      value: _selectedType,
                      items: <String>['All', 'Published', 'Favourite']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          alignment: Alignment.centerLeft,
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Search field
                  SizedBox(
                    width: constraints.maxWidth > 400
                        ? 400
                        : constraints.maxWidth * 0.6,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search bots',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(width: 8),
                  if (constraints.maxWidth > 600) const Spacer(),

                  // Create bot button
                  SizedBox(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle create bot action
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Create Bot',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 58, 183, 129),
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 20.0, 13.0, 20.0),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.start,
                children: [
                  IntrinsicWidth(
                    child: DropdownButtonFormField<String>(
                      isExpanded: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                      )),
                      value: _selectedType,
                      items: <String>['All', 'Published', 'Favourite']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          alignment: Alignment.centerLeft,
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Search field
                  SizedBox(
                    width: constraints.maxWidth > 400
                        ? 400
                        : constraints.maxWidth * 0.6,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search bots',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(width: 8),
                  if (constraints.maxWidth > 600) const Spacer(),

                  // Create bot button
                  SizedBox(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle create bot action
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Create Bot',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 58, 183, 129),
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 20.0, 13.0, 20.0),
                      ),
                    ),
                  )
                ],
              );
            }
          }),
        ),
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                    constraints.maxWidth < 600 ? constraints.maxWidth : 400.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 4.0,
                mainAxisExtent: 150.0,
              ),
              itemCount: 5, // Seed number of bots
              itemBuilder: (context, index) {
                /* Bot card (display bot information) */
                return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.android), // Bot Icon
                              const SizedBox(width: 8.0), // Spacing
                              Expanded(
                                // Allows text to take up remaining space
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Bot Name $index',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    Text(
                                      'Bot Description $index',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
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
                                Text(DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now())),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            );
          }),
        ),
      ],
    );
  }
}
