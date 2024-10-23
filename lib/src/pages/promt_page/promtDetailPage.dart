import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/infiniteScrollPromtList.dart';

enum OpenMode{edit, view, create}
class PromtDetailPage extends StatefulWidget {
  const PromtDetailPage({super.key, required this.title});
  final String title;


  @override
  State<StatefulWidget> createState() => _PromtDetailPage();
}

class _PromtDetailPage extends State<PromtDetailPage>{
  OpenMode? openMode;
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _contentController;


  @override
  Widget build(BuildContext context) {
    if (openMode==null) {
      final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
      openMode = arguments["openMode"] == null ? OpenMode.create : arguments["openMode"];
    }
    _nameController=TextEditingController(
        text: openMode==OpenMode.create?"":"name",
    );
    _categoryController=TextEditingController(text: openMode==OpenMode.create?"":"category");
    _contentController=TextEditingController(text: openMode==OpenMode.create?"":"structure");
    return Scaffold(
      appBar: AppBar(
        title: Text(openMode==OpenMode.create?"Create new promt":widget.title),
      ),
      body:Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (openMode==OpenMode.view)
                  Flexible(child:
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          openMode=OpenMode.edit;
                        });
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
                if (openMode!=OpenMode.view)Flexible(child:
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        openMode=OpenMode.view;
                      });
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
                if (openMode==OpenMode.view)Flexible(child:
                  ElevatedButton.icon(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete',),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(scrollbars: false),
              child: Expanded(child:SingleChildScrollView(
                child:Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.lightBlueAccent),
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
                                    fontSize: 18,
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 10,),
                          Padding(padding: EdgeInsets.all(0), child: Divider(height: 1)),
                          SizedBox(height: 10,),
                          TextField(
                            maxLines: null,
                            controller: _nameController,
                            enabled: openMode==OpenMode.view?false:true,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                ),
                              ),
                              disabledBorder: InputBorder.none,
                              hintText: "Enter your promt name",
                            ),
                            keyboardType: TextInputType.multiline,
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.lightBlueAccent),
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
                                    fontSize: 18,
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 10,),
                          Padding(padding: EdgeInsets.all(0), child: Divider(height: 1)),
                          SizedBox(height: 10,),
                          TextField(
                            maxLines: null,
                            controller: _categoryController,
                            enabled: openMode==OpenMode.view?false:true,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                              disabledBorder: InputBorder.none,
                              hintText: "Enter your promt category",
                            ),
                            keyboardType: TextInputType.multiline,
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.lightBlueAccent),
                      ),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Content",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 10,),
                          Padding(padding: EdgeInsets.all(0), child: Divider(height: 1)),
                          SizedBox(height: 10,),
                          TextField(
                            maxLines: null,
                            controller: _contentController,
                            enabled: openMode==OpenMode.view?false:true,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                              disabledBorder: InputBorder.none,
                              hintText: "Enter your promt content",
                            ),
                            keyboardType: TextInputType.multiline,
                          )
                        ],
                      ),
                    ),
                  ],
                ) ,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
