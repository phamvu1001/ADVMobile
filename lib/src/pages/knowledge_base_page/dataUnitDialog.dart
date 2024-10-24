
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DataUnitDialog extends StatelessWidget{
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
                                  "Unit Details",
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
                    ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            "abc.pdf",
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
                      "Size",
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
                        "10Mb",
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
                      "Created Time",
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
                        "2024/12/20 12:20:00 AM",
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
                      "Last update",
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
                        "2024/12/20 12:20:00 AM",
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
                      "Source",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    ),
                  ),
                ],
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
                        "Local file",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}