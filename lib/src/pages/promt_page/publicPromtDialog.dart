
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jarvis/src/models/prompt.dart';
import 'package:jarvis/src/pages/chat_page/conversationPage.dart';
import 'package:jarvis/src/pages/promt_page/promtPage.dart';
import 'package:jarvis/src/routes.dart';

class PublicPromptDialog extends StatelessWidget{
  PublicPromptDialog({super.key, required this.prompt});
  PromptModel prompt;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      child: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width*5/6.floor()>800?800:MediaQuery.of(context).size.width*5/6.floor(),
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                    children: [
                      Text("Promt Details",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                      Expanded(child:
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
                        ),),
                    ]
                ),
              ),
              Padding(padding: EdgeInsets.all(5), child: Divider(height: 1)),
              Container(
                height: MediaQuery.of(context).size.height*5/7.floor(),
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildProperty(context, "Language", prompt.language, null),
                        Divider(),
                        buildProperty(context, "Title", prompt.title, null),
                        Divider(),
                        buildProperty(context, "Category", prompt.category, null),
                        Divider(),
                        buildProperty(context, "Description", prompt.description, null),
                        Divider(),
                        buildProperty(context, "Content", prompt.content, "Repace square brackets with your information."),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context,Routes.newchat,arguments: prompt.content);
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
  Widget buildProperty(BuildContext context, String property, String? value, String? note){
    return Container(
      child: Column(
        children: [
          Row(
          children: [
            Expanded(
              child: Text(property,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
              ),
            ),
          ],
          ),
          if(note!=null) Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue.shade50,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(note??"",style: TextStyle(fontSize: 14),
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
                  child: Text(value??"",style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}