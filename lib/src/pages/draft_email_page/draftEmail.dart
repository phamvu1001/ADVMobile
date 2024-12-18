import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jarvis/src/constant/aiEmailAction.dart';
import 'package:jarvis/src/constant/assistants.dart';
import 'package:jarvis/src/constant/language.dart';
import 'package:jarvis/src/navigation.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:jarvis/src/models/chat/assistant_model.dart';
import 'package:jarvis/src/pages/draft_email_page/aiEmailActionSelector.dart';
import 'package:jarvis/src/pages/draft_email_page/suggestIdeaDialog.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/services/aiEmailServices.dart';
import 'package:jarvis/src/services/chatServices.dart';
import 'package:provider/provider.dart';

class DraftEmailPage extends StatefulWidget {
  const DraftEmailPage({super.key, required this.title});

  final String title;

  @override
  State<DraftEmailPage> createState() => _DraftEmailPageState();
}

class _DraftEmailPageState extends State<DraftEmailPage> {
  final TextEditingController _controller = TextEditingController();
  IconData? selectedIcon = Icons.invert_colors_on_sharp;
  String _selectedEmailAction="Reply to this email";


  void onActionSelectionChange(String value){
    _selectedEmailAction=value;
  }

  String _selectedEmailLength="long";


  void onLengthSelectionChange(String value){
    _selectedEmailLength=value;
  }
  String _selectedEmailTone="friendly";


  void onToneSelectionChange(String value){
    _selectedEmailTone=value;
  }
  String _selectedEmailFormality="neutral";


  void onFormalitySelectionChange(String value){
    _selectedEmailFormality=value;
  }
  late TextEditingController _emailController=TextEditingController();
  late TextEditingController _ideaController=TextEditingController();
  late TextEditingController _senderController=TextEditingController();
  late TextEditingController _genEmailController=TextEditingController();
  bool isValidEmailContent=true;
  bool isValidIdeaContent=true;
  bool isValidSenderContent=true;
  bool isGenerating=false;
  String _selectedAssistantId = 'gpt-4o-mini';
  String _selectedLanguage = 'english';
  bool verify(){
    setState(() {
      isValidEmailContent=!_emailController.text.trim().isEmpty;
    });
    setState(() {
      isValidSenderContent=!_senderController.text.trim().isEmpty;
    });
    setState(() {
      isValidIdeaContent=!_ideaController.text.trim().isEmpty;
    });
    return isValidSenderContent&&isValidIdeaContent&&isValidEmailContent;
  }

  bool verifyGenIdeas(){
    setState(() {
      isValidEmailContent=!_emailController.text.trim().isEmpty;
    });
    setState(() {
      isValidSenderContent=!_senderController.text.trim().isEmpty;
    });
    return isValidSenderContent&&isValidEmailContent;
  }

  Future<void> onGenerateClick(String token) async {
    if(verify() && !isGenerating){
      setState(() {
        isGenerating=true;
      });
      dynamic result =await AIEmailServices.generateEmail(
          token: token,
          email: _emailController.text.trim(),
          action: _selectedEmailAction,
          idea: _ideaController.text.trim(),
          language: _selectedLanguage,
          sender: _senderController.text.trim(),
          tone: _selectedEmailTone,
          length: _selectedEmailLength,
          formality: _selectedEmailFormality);
      _genEmailController.text=result['email'];
      setState(() {
        isGenerating=false;
      });
    }
  }
  Future<void> _showSuggestDialog(BuildContext context) async {
    if(verifyGenIdeas()) {
      String? selectedItem = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SuggestEmailIdeaDialog(
            email: _emailController.text.trim(),
            sender: _senderController.text.trim(),
            language: _selectedLanguage,
            onSelectedItem: (value) =>
            {
              setState(() {
                _ideaController.text = value;
              })
            },);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "  Your Received Email",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Container(
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
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Enter your email here",
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                        )
                    ),
                  ],
                ),
              ),
              if(!isValidEmailContent)Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red.shade50,
                ),
                child: Text("Email cannot be empty",style: TextStyle(fontSize: 14),),
              ),
              SizedBox(height: 10,),
              Text(
                "  Main Reply Idea",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: _ideaController,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Enter your reply idea here",
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                        )
                    ),
                  ],
                ),
              ),
              if(!isValidIdeaContent)Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red.shade50,
                ),
                child: Text("Idea cannot be empty",style: TextStyle(fontSize: 14),),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _showSuggestDialog(context);
                    },
                    icon: const Icon(HugeIcons.strokeRoundedAiIdea,color: Colors.blue,),
                    label: const Text('Suggest me some ideas', style: TextStyle(color: Colors.blue),),
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
              SizedBox(height: 10,),
              Text(
                "  Sender",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: _senderController,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          maxLines: 2,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Who will the generated email be send to?",
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                        )
                    ),
                  ],
                ),
              ),
              if(!isValidSenderContent)Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red.shade50,
                ),
                child: Text("Sender cannot be empty",style: TextStyle(fontSize: 14),),
              ),
              SizedBox(height: 10,),
              AiEmailActionSelector(onSelectionChange: onActionSelectionChange, items: AIEmail.options, title: 'AI Email Action', defaultValue: 'Reply to this email',),
              SizedBox(height: 10,),
              AiEmailActionSelector(onSelectionChange: onLengthSelectionChange, items: AIEmail.length, title: 'Length', defaultValue: 'long',),
              SizedBox(height: 10,),
              AiEmailActionSelector(onSelectionChange: onToneSelectionChange, items: AIEmail.tone, title: 'Tone', defaultValue: 'friendly',),
              SizedBox(height: 10,),
              AiEmailActionSelector(onSelectionChange: onFormalitySelectionChange, items: AIEmail.formality, title: 'Formality', defaultValue: 'neutral',),
              SizedBox(height: 10,),
              Divider(height: 1,),
              Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Text(
                        "Assistant",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5,),
                      IntrinsicWidth(
                        child: DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            isDense: false,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          value: _selectedAssistantId,
                          items: Assistants.menuItems.map((entry) {
                            final Assistant key = entry.keys.first;
                            final Widget icon = entry.values.first;
                            return DropdownMenuItem<String>(
                              value: key.id, // Use the key as the value
                              child: Row(
                                children: [
                                  ClipOval(
                                      child: SizedBox(
                                          width: 30, height: 30, child: icon)),
                                  const SizedBox(width: 10),
                                  Text(key.name,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.blue)),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedAssistantId = value!;
                            });
                          },
                          selectedItemBuilder: (BuildContext context) {
                            return Assistants.menuItems.map((entry) {
                              final Assistant key = entry.keys.first;
                              final Widget icon = entry.values.first;
                              return Row(
                                children: [
                                  ClipOval(
                                    child: SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: icon,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    key.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              );
                            }).toList();
                          },
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Expanded(child: Column(
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5,),
                      IntrinsicWidth(
                        child: DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            isDense: false,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          value: _selectedLanguage,
                          items: languageList.map((item) {
                            return DropdownMenuItem<String>(
                              value: item['name'],
                              child: Text(item['nativeName']!,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedLanguage = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: isGenerating?SizedBox(height: 20,width: 20,
                        child: CircularProgressIndicator(color: Colors.white,)):Icon(HugeIcons.strokeRoundedPenTool03,color: Colors.white,),
                    onPressed: () {
                      onGenerateClick(authProvider.token??"");
                    },
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Generate', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(width: 1, color: Colors.blue.shade100),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(
                "  Your draft email",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: _genEmailController,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          maxLines: 20,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Enter your reply idea here",
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                        )
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
