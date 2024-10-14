
import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/chat_page/chatPage.dart';
import 'package:jarvis/src/pages/home_page/homePage.dart';
import 'package:jarvis/src/pages/personal_page/personalPage.dart';
import 'package:jarvis/src/pages/settings_page/settingsPage.dart';

class NavigationMenu extends StatefulWidget{
  const NavigationMenu({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>{
  int _selectedIndex=0;
  List <IconData> icons=[ Icons.home_outlined, Icons.chat_outlined, Icons.person, Icons.settings ];
  List <String> labels=["Home","Chat", "Personal", "Settings"];
  List <Widget> pages=[
    const MyHomePage(title: 'Home'),
    const ChatPage(title: 'Chat'),
    const PersonalPage(title: 'Personal'),
    const SettingsPage(title: 'Settings'),
  ];
  List <String> titles=["Home","Chat", "Personal", "Settings"];
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
      width: 200,
      height:200,
      child: ListView.builder(
        itemCount: 3,
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



