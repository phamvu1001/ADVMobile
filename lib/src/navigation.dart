import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jarvis/src/pages/account_page/accountPage.dart';
import 'package:jarvis/src/pages/chat_bot_page/chatBotPage.dart';
import 'package:jarvis/src/pages/chat_page/chatPage.dart';
import 'package:jarvis/src/pages/chat_page/conversationPage.dart';
import 'package:jarvis/src/pages/draft_email_page/draftEmail.dart';
import 'package:jarvis/src/pages/home_page/homePage.dart';
import 'package:jarvis/src/pages/knowledge_base_page/knowledgeBasePage.dart';
import 'package:jarvis/src/pages/personal_page/personalPage.dart';
import 'package:jarvis/src/pages/promt_page/promtPage.dart';
import 'package:jarvis/src/pages/settings_page/settingsPage.dart';
import 'package:jarvis/src/routes.dart';

class NavigationMenu extends StatefulWidget{
  const NavigationMenu({super.key, this.initialIndex = 0, this.pageTab = 0});

  final int initialIndex;
  final int pageTab;

  @override
  State<StatefulWidget> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>{
  late int _selectedIndex = 0;
  late int _pageTab = 1;

  List <IconData> icons=[ HugeIcons.strokeRoundedHome05,
                          HugeIcons.strokeRoundedChatting01,
                          HugeIcons.strokeRoundedMailEdit02,
                          HugeIcons.strokeRoundedCollectionsBookmark,
                          HugeIcons.strokeRoundedChatBot,
                          HugeIcons.strokeRoundedDatabase,
                          HugeIcons.strokeRoundedSettings02,
                          HugeIcons.strokeRoundedUserCircle ];
  List <String> labels=["Home","Chat", "Draft Email","Prompt","Chat bot","Knowledge base", "Settings","Account"];
  late List<Widget> pages;

  List <String> titles=["Home","Chat","Draft Email","Prompt","Chat bot","Knowledge base", "Settings","Account"];
  final PageController pageController = PageController();
  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pageTab = widget.pageTab;
    pages = [
      const MyHomePage(title: 'Home'),
      const ChatPage(title: 'Chat'),
      const DraftEmailPage(title: 'Draft Email'),
      const PromptManagementPage(title: "Promt"),
      // PersonalPage(title: 'Personal', tab: _pageTab),
      const ChatBotPage(),
      const KnowledgeBasePage(),
      const SettingsPage(title: 'Settings'),
      const AccountPage(title: "Account"),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(_selectedIndex);
    });
  }

  List<Widget> _buildActions() {
    switch (_selectedIndex) {
      case 1:
        return [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () { 
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ConversationPage()));
            },
          ),
        ];
      case 2 :
        return [
            Row(children: [
              Text(
                "25",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Image.asset(
                'assets/fire-icon.png',
                height: 25,
                width: 25,
              ),
            ])

        ];
      default:
        return []; // Return an empty list for other indices
    }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar:AppBar(
      title: Text(titles[_selectedIndex],),
      actions: _buildActions(),
    ) ,
    drawer: Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            buildHeader(context),
            buildMenuItems(context),
            buildBottomAction(context),
          ],
        ),
      ),
    ),
    body: PageView(
      children: pages,
      controller: pageController,
      onPageChanged: onPageChanged,
    ),
  );

  Widget buildMenuItems(BuildContext context) =>Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
      width: MediaQuery.of(context).size.width,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: index==_selectedIndex?Colors.blueAccent.withOpacity(0.2):Colors.transparent,
              textColor: index==_selectedIndex?Colors.blueAccent:Colors.black,
              leading:  HugeIcon(icon: icons[index], color: index==_selectedIndex?Colors.blueAccent:Colors.black),
              title:  Text(labels[index], style: TextStyle(fontWeight: FontWeight.w500),),
              onTap: (){
                setState(() {
                  pageController.jumpToPage(index);
                  _selectedIndex=index;
                });
                Navigator.pop(context);
              },
            );
          },
        ),
      ));

  Widget buildHeader(BuildContext context) =>Container(
      padding: EdgeInsets.only(
          top:MediaQuery.of(context).padding.top
      ),
      child: Column(
        children: [
          Text("Viras", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.blueAccent),),
          Row(
            children: [
              Expanded(child: Container(child: Divider(),)),
            ],
          ),
        ],
      ),
  );
  Widget buildBottomAction(BuildContext context) => Container(
    child: Column(
      children: [
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.red.withOpacity(0.2),
            textColor: Colors.black,
            leading:  HugeIcon(icon: HugeIcons.strokeRoundedLogout01, color: Colors.black),
            title:  Text("Logout", style: TextStyle(fontWeight: FontWeight.w500),),
            onTap: (){
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
          ),
        ),
      ],
    ),
  );
}



