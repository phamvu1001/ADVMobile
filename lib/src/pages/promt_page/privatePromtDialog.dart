
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jarvis/src/models/prompt.dart';
import 'package:jarvis/src/pages/chat_page/conversationPage.dart';
import 'package:jarvis/src/pages/promt_page/promtPage.dart';
import 'package:jarvis/src/routes.dart';
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
  bool checkEmpty(String text){
    if(text.trim()==""){
      return false;
    }
    return true;
  }

  void onSaveButtonTap(BuildContext context, String token){
    setState(() {
      isValidTitle=checkEmpty(_nameController.text.toString());
      isValidContent=checkEmpty(_promtController.text.toString());
    });
    if(!(isValidContent&&isValidTitle)){
      return;
    }
    if(widget.openMode==OpenMode.create){
      PromptServices().createNewPrivatePrompt(
          toBeCreatedPromt: new PromptModel(
              title: _nameController.text,
              isPublic: false,
              content: _promtController.text),
          accessToken: token);
      widget.onCreate();
    }else{
      //update
      widget.prompt?.title=_nameController.text;
      widget.prompt?.content=_promtController.text;
      widget.onUpdate(widget.prompt);
    }
    Navigator.pop(context);
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
              buildPropertyFrame(context, "Name", "Name cannot be empty", null, "Enter your prompt name here",
                                                                        isValidTitle, _nameController, widget.openMode),
              Divider(),
              buildPropertyFrame(context, "Content", "Content cannot be empty", null, "Enter your prompt content here",
                  isValidContent, _promtController, widget.openMode),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if(widget.openMode==OpenMode.view)ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context,Routes.newchat,arguments: _promtController.text);
                    },
                    icon: const Icon(HugeIcons.strokeRoundedChatting01,color: Colors.blue,),
                    label: const Text('Chat', style: TextStyle(color: Colors.blue),),
                  ),
                  if(widget.openMode!=OpenMode.view)ElevatedButton.icon(
                    onPressed: () =>onSaveButtonTap(context,authProvider.token!),
                    icon: const Icon(HugeIcons.strokeRoundedDownload01,color: Colors.blue,),
                    label: const Text('Save', style: TextStyle(color: Colors.blue),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildPropertyFrame(
      BuildContext context,
      String name,
      String? alert,
      String? note,
      String? hint,
      bool? checkValidVariable,
      TextEditingController controller,
      OpenMode mode){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
        if(!checkValidVariable!)Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.red.shade50,
          ),
          child: Text(alert!,style: TextStyle(fontSize: 14),),
        ),
        if(note!=null)Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue.shade50,
          ),
          child: Text(note!,style: TextStyle(fontSize: 14),),
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
                    controller: controller,
                    enabled: mode==OpenMode.view?false:true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: hint??"",
                      focusedBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}