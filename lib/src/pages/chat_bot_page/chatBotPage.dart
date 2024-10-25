import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:jarvis/src/widgets/searchBar.dart';
import 'botPreviewPage.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPage();
}

class _ChatBotPage extends State<ChatBotPage> {
  String _selectedType = 'All';
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _botNameController = TextEditingController();
  final TextEditingController _botDescriptionController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(builder: (context, constraints) {
            if (MediaQuery.of(context).size.width > 600) {
              return Row(
                children: [
                  IntrinsicWidth(
                    child: DropdownButtonFormField2<String>(
                      isExpanded: false,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                          )),
                      value: _selectedType,
                      items: <String>['All', 'Published', 'Favourite']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: const TextStyle( fontSize: 14, ),),
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
                  Expanded(child: CustomSearchBar()),
                  if (MediaQuery.of(context).size.width > 600)
                    const SizedBox(
                      width: 8,
                    ),
                  // Create bot button
                  SizedBox(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle create bot action
                        _showCreateBotDialog(context);
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Create Bot',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.blue,
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
                  Row(
                    children: [
                      IntrinsicWidth(
                        child: DropdownButtonFormField2<String>(
                          isExpanded: false,
                          dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                              )),
                          value: _selectedType,
                          items: <String>['All', 'Published', 'Favourite']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 14),),
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
                      Expanded(
                        // width: constraints.maxWidth > 400
                        //     ? 400
                        //     : constraints.maxWidth * 0.6,
                        child: CustomSearchBar(),
                      ),
                    ],
                  ),

                  // Create bot button
                  SizedBox(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle create bot action
                        _showCreateBotDialog(context);
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Create Bot',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor:Colors.blue,
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
                MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width : 400.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 4.0,
                mainAxisExtent: 150.0,
              ),
              itemCount: 5, // Seed number of bots
              itemBuilder: (context, index) {
                /* Bot card (display bot information) */
                return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BotPreviewPage(
                                botName: 'Bot Name $index',
                              )));
                        },
                        child: Card(
                          color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: Colors.blue.shade200, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(HugeIcons.strokeRoundedChatBot), // Bot Icon
                                      const SizedBox(width: 8.0), // Spacing
                                      Expanded(
                                        // Allows text to take up remaining space
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text('Bot Name $index',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge),
                                            Text(
                                              'Bot Description $index',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
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
                            )
                        )
                    )
                );
              },
            );
          }),
        ),
      ],
    );
  }

  void _showCreateBotDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create new assistant'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      controller: _botNameController,
                      decoration: InputDecoration(
                        hintText: 'Assistant Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 0),
                        ),
                      )),
                  const SizedBox(height: 8.0),
                  TextFormField(
                      controller: _botDescriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Assistant Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 0),
                        ),
                      ))
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
                  Navigator.of(context).pop(); // Navigate to Bot Preview page
                },
                child: const Text(
                  'Create',
                ),
              )
            ],
          );
        });
  }
}
