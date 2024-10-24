
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jarvis/src/pages/promt_page/promtPage.dart';
import 'package:jarvis/src/routes.dart';

class PublicPromptDialog extends StatelessWidget{
  List<String> _categoryList=["Cat 1", "Cat 2", "Cat 3"];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      child: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width*5/6.floor()>800?800:MediaQuery.of(context).size.width*2/3.floor(),
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
                                "Promt Details",
                                style: TextStyle(
                                  fontSize: 18,
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
              Padding(padding: EdgeInsets.all(5), child: Divider(height: 1)),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Promt Language",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
                child: Row(
                  children: [
                    ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            "English",
                            softWrap: true,
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Generate short paragraph",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Category",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Seo",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Promt usage",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Promt",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue.shade50,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Repace square brackets with your information.",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Describe a dream vacation spot for an AI to generate a virtual postcard image.",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                      ElevatedButton.icon(
                        onPressed: () {
                        },
                        icon: const Icon(HugeIcons.strokeRoundedChatting01,color: Colors.blue,),
                        label: const Text('Chat', style: TextStyle(color: Colors.blue),),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: BorderSide(width: 1, color: Colors.blue.shade100),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}