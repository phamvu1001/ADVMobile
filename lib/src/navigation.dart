
import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/account_page/accountPage.dart';
import 'package:jarvis/src/pages/chat_page/chatPage.dart';
import 'package:jarvis/src/pages/draftEmail_page/draftEmail.dart';
import 'package:jarvis/src/pages/home_page/homePage.dart';
import 'package:jarvis/src/pages/personal_page/personalPage.dart';
import 'package:jarvis/src/pages/promt_page/promptPage.dart';
import 'package:jarvis/src/pages/settings_page/settingsPage.dart';

class NavigationMenu extends StatefulWidget{
  const NavigationMenu({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>{
  int _selectedIndex=0;
  List <IconData> icons=[ Icons.home_outlined, Icons.chat_outlined, Icons.person, Icons.settings,Icons.email_outlined,Icons.library_books_outlined, Icons.account_circle_outlined ];
  List <String> labels=["Home","Chat", "Personal", "Settings","Draft Email","Promt","Account"];
  List <Widget> pages=[
    const MyHomePage(title: 'Home'),
    const ChatPage(title: 'Chat'),
    const PersonalPage(title: 'Personal'),
    const SettingsPage(title: 'Settings'),
    const DraftEmailPage(title: 'Draft Email'),
    const PromptManagementPage(title: "Promt"),
    const AccountPage(title: "Account"),
  ];
  List <String> titles=["Home","Chat", "Personal", "Settings","Draft Email","Promt","Account"];
  final pageController = PageController();
  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar:AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(titles[_selectedIndex]),
    ) ,
    drawer: Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
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
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading:  Icon(icons[index]),
            title:  Text(labels[index]),
            onTap: (){
              setState(() {
                pageController.jumpToPage(index);
              });
              Navigator.pop(context);
            },
          );
        },
      ));

  Widget buildHeader(BuildContext context) =>Container(
      padding: EdgeInsets.only(
          top:MediaQuery.of(context).padding.top
      )
  );
}



