import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/infiniteScrollPromtList.dart';

class PromtDetailPage extends StatelessWidget {
  const PromtDetailPage({super.key, required this.title});


  final String title;

  @override
  Widget build(BuildContext context) =>Scaffold(
    appBar: AppBar(
      title: Text(title),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
    body:Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(child:
              ElevatedButton.icon(
                onPressed: () {
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              ),
              Flexible(child:
              ElevatedButton.icon(
                onPressed: () {
                },
                icon: const Icon(Icons.save_alt),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              ),
              Flexible(child:
              ElevatedButton.icon(
                onPressed: () {
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              ),
            ],
          ),
          ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: Expanded(child:SingleChildScrollView(
            child:Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                      ),
                      Padding(padding: EdgeInsets.all(0), child: Divider(height: 1)),
                      TextField(
                        controller: TextEditingController(text: "Promt name text field"),
                        enabled: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          disabledBorder: InputBorder.none,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(20)),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                      ),
                      Padding(padding: EdgeInsets.all(0), child: Divider(height: 1)),
                      TextField(
                        controller: TextEditingController(text: "Promt category field"),
                        enabled: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          disabledBorder: InputBorder.none,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(20)),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Structure",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                      ),
                      Padding(padding: EdgeInsets.all(0), child: Divider(height: 1)),
                      TextField(
                        controller: TextEditingController(text: "PROMPT, an acronym for PROMPTS for Restructuring Oral Muscular"
                            " Phonetic Targets, is a multidimensional approach to speech production "
                            "disorders that has come to embrace not only the well-known physical-sensory aspects of "
                            "motor performance, but also its cognitive-linguistic and social-emotional aspects. "
                            "PROMPT is about integrating all domains and systems toward positive communication outcomes. "
                            "It may be used (with varying intensity and focus) with all speech production disorders from "
                            "approximately 6 months of age onward. To achieve the best outcome with PROMPT it should not be "
                            "thought of or used mainly to facilitate oral-motor skills, produce individual sounds/phonemes or"
                            " as an articulation program but rather as a program to develop motor skill in the development of "
                            "language for interaction."),
                        enabled: false,
                        maxLines: null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          disabledBorder: InputBorder.none,
                        ),
                      )
                    ],
                  ),
                )
                ,
              ],
            ) ,
          )),
      ),
      ],
      ),
    ),
  );
}
