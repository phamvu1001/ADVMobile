import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/ShiningBorderContainer.dart';
import 'package:jarvis/src/routes.dart';

class UpgradeOptionPage extends StatefulWidget {
  const UpgradeOptionPage({super.key, required this.title});

  final String title;



  @override
  State<StatefulWidget> createState() => _UpgradeOptionPage();
}
class _UpgradeOptionPage extends State<UpgradeOptionPage>{
  @override
  Widget build(BuildContext context) =>Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      title: Text(widget.title),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
    body:
    ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            buildOptionCard("", Colors.black12),
            buildOptionCard("", Colors.black12),
            buildOptionCard("", Colors.black12)
          ],
        ),
      ),
    ),
  );
}

Widget buildOptionCard(dynamic optionData, Color backgroundColor)=>
    Padding(
        padding: EdgeInsets.all(30),
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: AnimatedGradientBorder(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sunny),
                      Text(
                        "Basic",
                        style: TextStyle(
                          fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Free",
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                    },
                    label: const Text('Buy now'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5), child: Divider(height:1)),
                  Padding(padding: EdgeInsets.all(10), child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [Text(
                        "Basic features",
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        ]
                      ),
                    ],
                  ),),
                  Padding(padding: EdgeInsets.all(5), child: Divider(height:1)),
                  Padding(padding: EdgeInsets.all(10), child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          children: [Text(
                            "Advanced",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ]
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index){
                          return ListTile(
                            leading: Icon(Icons.check_circle_outline),
                            title: Text(
                              "Good Good Good Good Good Good Good Good Good Good Good Good ",
                              softWrap: true,
                            ),

                          );
                        },
                      ),
                    ],
                  ),),
                  Padding(padding: EdgeInsets.all(5), child: Divider(height:1)),
                  Padding(padding: EdgeInsets.all(10), child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          children: [Text(
                            "Others features",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ]
                      ),
                    ],
                  ),),
                ],
              ),
            ),
          ),
        ),
);