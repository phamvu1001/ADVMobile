
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/promtDetailPage.dart';
import 'package:jarvis/src/routes.dart';

class PromptDialog extends StatelessWidget{
  List<String> _categoryList=["Cat 1", "Cat 2", "Cat 3"];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width*2/3.floor()>800?800:MediaQuery.of(context).size.width*2/3.floor(),
        height: MediaQuery.of(context).size.height*2/3.floor() >800?800:MediaQuery.of(context).size.height*2/3.floor(),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                  children: [
                      Expanded(child: Column(
                          children: [
                            Row(children: [
                              Expanded(child:
                                Text(
                              "Promt 11",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            )
                            ]
                            ),
                          ]
                    ),),
                    Expanded(child:
                      Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                            IconButton(
                              icon: Icon(Icons.close), // Icon cho button đầu tiên
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ]
                          ),
                        ]
                    ),),

                  ]
              ),
            ),
            Padding(padding: EdgeInsets.all(10), child: Divider(height: 1)),
            Text(
              "Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child: Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: -4,
                      children: List<Widget>.generate(
                        _categoryList.length,
                            (index) => Chip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.transparent),
                              ),
                              backgroundColor: Colors.lightBlue[50],
                              label: Text(
                                _categoryList[index],
                                style: const TextStyle(fontSize: 14, color: Colors.blue),
                              ),
                        ),
                      ),
                    ),
                ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10), child: Divider(height: 1)),
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(scrollbars: false),
                  child: Expanded(
                    flex:3,
                    child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                      child: Text(
                    "PROMPT, an acronym for PROMPTS for Restructuring Oral Muscular"
                        " Phonetic Targets, is a multidimensional approach to speech production "
                        "disorders that has come to embrace not only the well-known physical-sensory aspects of "
                        "motor performance, but also its cognitive-linguistic and social-emotional aspects. "
                        "PROMPT is about integrating all domains and systems toward positive communication outcomes. "
                        "It may be used (with varying intensity and focus) with all speech production disorders from "
                        "approximately 6 months of age onward. To achieve the best outcome with PROMPT it should not be "
                        "thought of or used mainly to facilitate oral-motor skills, produce individual sounds/phonemes or"
                        " as an articulation program but rather as a program to develop motor skill in the development of "
                        "language for interaction.",
                    softWrap: true,
                  )
                  ),
              ),),
            ),
            Padding(padding: EdgeInsets.all(10), child: Divider(height: 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                  Expanded(
                    child: Wrap(
                      spacing: 10.0,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: [
                        Flexible(child:
                        ElevatedButton.icon(
                          onPressed: () {
                          },
                          icon: const Icon(Icons.messenger_outline_rounded),
                          label: const Text('Chat'),
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
                            Navigator.pushNamed(context, Routes.detail_promt,arguments:{"openMode":OpenMode.edit});
                          },
                          icon: const Icon(Icons.mode_edit_outlined),
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
                            Navigator.pushNamed(context, Routes.detail_promt,arguments:{"openMode":OpenMode.view});
                          },
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          label: const Text('Details'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                        ),
                    ],
                  ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}