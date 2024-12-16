import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/services/aiEmailServices.dart';
import 'package:provider/provider.dart';

class SuggestEmailIdeaDialog extends StatefulWidget {
  SuggestEmailIdeaDialog({super.key, required this.email,required this.onSelectedItem, required this.sender, required this.language});

  final String email;
  final onSelectedItem;
  final String sender;
  final String language;

  @override
  State<StatefulWidget> createState() => _SuggestEmailIdeaDialog ();
}

class _SuggestEmailIdeaDialog  extends State<SuggestEmailIdeaDialog>{
  bool isGenerating=true;
  List<String> items=["1","2","3"];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      loadIdeas(authProvider.token??"");
    });
  }

  Future<void> loadIdeas(String token) async {
    dynamic result=await AIEmailServices.generateReplyIdeas(
        token: token,
        email: widget.email,
        language: widget.language,
        sender: widget.sender);
    setState(() {
      isGenerating=false;
      items=result['ideas'].cast<String>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Some Suggest Ideas',style: TextStyle(fontSize: 14, color: Colors.blue),),
      content: Container(
        width: double.maxFinite,
        height: 200,
        child: isGenerating?
        Center(
          child: Container(
              height:20,
              width:20,
              child: CircularProgressIndicator(color: Colors.blueAccent,)
          ),
        )
            :ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${index+1}. "+items[index], maxLines: 3,style: TextStyle(fontSize: 14),),
                  onTap: () {
                    Navigator.pop(context);  // Đóng dialog
                    widget.onSelectedItem(items[index]);  // Trả về chuỗi đã chọn
                  },
                );
          },
        ),
      ),
    );
  }
}
