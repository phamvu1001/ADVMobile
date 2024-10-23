
import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/account_page/accountPage.dart';
import 'package:jarvis/src/pages/chat_page/chatPage.dart';
import 'package:jarvis/src/pages/draftEmail_page/draftEmail.dart';
import 'package:jarvis/src/pages/home_page/homePage.dart';
import 'package:jarvis/src/pages/personal_page/personalPage.dart';
import 'package:jarvis/src/pages/promt_page/promptPage.dart';
import 'package:jarvis/src/pages/settings_page/settingsPage.dart';

class NavigationMenu extends StatefulWidget{
  const NavigationMenu({super.key, this.initialIndex = 0, this.pageTab = 0});

  final int initialIndex;
  final int pageTab;

  @override
  State<StatefulWidget> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>{
  late int _selectedIndex = 0;
  late int _pageTab = 0;

  List <IconData> icons=[ Icons.home_outlined, Icons.chat_outlined, Icons.person, Icons.settings,Icons.email_outlined,Icons.library_books_outlined, Icons.account_circle_outlined ];
  List <String> labels=["Home","Chat", "Personal", "Settings","Draft Email","Prompt","Account"];
  late List<Widget> pages;

  List <String> titles=["Home","Chat", "Personal", "Settings","Draft Email","Prompt","Account"];
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
      PersonalPage(title: 'Personal', tab: _pageTab),
      const SettingsPage(title: 'Settings'),
      const DraftEmailPage(title: 'Draft Email'),
      const PromptManagementPage(title: "Promt"),
      const AccountPage(title: "Account"),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(_selectedIndex);
    });
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar:AppBar(
      title: Text(titles[_selectedIndex]),
    ) ,
    drawer: Drawer(
      backgroundColor: Colors.white,
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



