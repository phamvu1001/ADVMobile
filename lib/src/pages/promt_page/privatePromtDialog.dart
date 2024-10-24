
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jarvis/src/pages/promt_page/promtPage.dart';

class PrivatePromptDialog extends StatefulWidget{
  const PrivatePromptDialog({super.key, required this.openMode});
  final OpenMode openMode;
  @override
  State<StatefulWidget> createState() => _PrivatePromtDialog();
}
class _PrivatePromtDialog extends State<PrivatePromptDialog>{
  late TextEditingController _nameController;
  late TextEditingController _promtController;
  @override
  void initState(){
    super.initState();
    _promtController=TextEditingController(text: widget.openMode==OpenMode.create?"":"Name");
    _nameController=TextEditingController(text: widget.openMode==OpenMode.create?"":"Promt");
  }
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
                                widget.openMode==OpenMode.create?"Create New Promt":"Promt Details",
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
                        child: TextField(
                          cursorColor: Colors.black,
                          style: TextStyle(fontSize: 14),
                          maxLines: null,
                          controller: _promtController,
                          enabled: widget.openMode==OpenMode.view?false:true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Enter your promt name here",
                          ),
                          keyboardType: TextInputType.multiline,
                        )
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

              SizedBox(height: 10,),
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
                        "Using square brackets to specify user inputs",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          cursorColor: Colors.black,
                          style: TextStyle(fontSize: 14),
                          maxLines: null,
                          controller: _promtController,
                          enabled: widget.openMode==OpenMode.view?false:true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Enter your promt here",
                          ),
                          keyboardType: TextInputType.multiline,
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if(widget.openMode==OpenMode.view)ElevatedButton.icon(
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
                  if(widget.openMode!=OpenMode.view)ElevatedButton.icon(
                    onPressed: () {
                    },
                    icon: const Icon(HugeIcons.strokeRoundedDownload01,color: Colors.blue,),
                    label: const Text('Save', style: TextStyle(color: Colors.blue),),
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
            ],
          ),
        ),
      ),
    );
  }
}