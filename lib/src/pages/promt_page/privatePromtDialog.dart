
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jarvis/src/models/prompt.dart';
import 'package:jarvis/src/pages/promt_page/promtPage.dart';
import 'package:jarvis/src/services/promptServices.dart';
import 'package:provider/provider.dart';

import '../../providers/authProvider.dart';

class PrivatePromptDialog extends StatefulWidget{
  PrivatePromptDialog({super.key, required this.openMode, this.onCreate, this.onUpdate, this.prompt});
  final OpenMode openMode;
  final onCreate;
  final onUpdate;
  PromptModel? prompt;
  @override
  State<StatefulWidget> createState() => _PrivatePromtDialog();
}
class _PrivatePromtDialog extends State<PrivatePromptDialog>{
  late TextEditingController _nameController;
  late TextEditingController _promtController;
  bool isValidTitle=true;
  bool isValidContent=true;
  @override
  void initState(){
    super.initState();
    _promtController=TextEditingController(text: widget.openMode==OpenMode.create?"":widget.prompt?.content!);
    _nameController=TextEditingController(text: widget.openMode==OpenMode.create?"":widget.prompt?.title!);
  }
  bool checkValidData(){
    if(_nameController.text.trim()==""){
      setState(() {
        isValidTitle=false;
      });
      return false;
    }
    setState(() {
      isValidTitle=true;
    });
    if(_promtController.text.trim()==""){
      setState(() {
        isValidContent=false;
      });
      return false;
    }
    setState(() {
      isValidContent=true;
    });
    return true;
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                    children: [
                      Text(
                      widget.openMode==OpenMode.create?"Create New Promt":"Promt Details",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                      Expanded(child:
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(icon: Icon(Icons.close), onPressed: () {
                                  Navigator.of(context).pop();
                                },)
                            ]
                        ),
                      ),
                    ]
                ),
              Divider(),
              Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
              SizedBox(height: 10,),
              if(!isValidTitle)Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red.shade50,
                ),
                child: Text("Name cannot be empty!",style: TextStyle(fontSize: 14),),
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
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          maxLines: 5,
                          minLines: 1,
                          controller: _nameController,
                          enabled: widget.openMode==OpenMode.view?false:true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Enter your promt name here",
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                        )
                    ),
                  ],
                ),
              ),
              Divider(),
              Text("Prompt",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
              SizedBox(height: 10,),
              if(!isValidContent)Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red.shade50,
                ),
                child: Text("Content cannot be empty!",style: TextStyle(fontSize: 14),),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue.shade50,
                ),
                child: Text("Using square brackets to specify user inputs",style: TextStyle(fontSize: 14),),
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
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          maxLines: 5,
                          minLines: 1,
                          controller: _promtController,
                          enabled: widget.openMode==OpenMode.view?false:true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Enter your promt here",
                            focusedBorder: InputBorder.none,
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
                      if(!checkValidData()){
                        return;
                      }
                      if(widget.openMode==OpenMode.create){
                          Navigator.pop(context);
                          PromptServices().createNewPrivatePrompt(
                              toBeCreatedPromt: new PromptModel(
                                  title: _nameController.text,
                                  isPublic: false,
                                  content: _promtController.text),
                              accessToken: authProvider.token!);
                          widget.onCreate();
                      }else{
                        //update
                        widget.prompt?.title=_nameController.text;
                        widget.prompt?.content=_promtController.text;
                        widget.onUpdate(widget.prompt);
                        Navigator.pop(context);
                      }

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