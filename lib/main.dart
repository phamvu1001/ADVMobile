import 'package:flutter/material.dart';
import 'package:jarvis/src/navigation.dart';
import 'package:jarvis/src/pages/account_page/upgradeOptionsPage.dart';
import 'package:jarvis/src/pages/chat_page/chatPage.dart';
import 'package:jarvis/src/pages/draftEmail_page/draftEmail.dart';
import 'package:jarvis/src/pages/home_page/homePage.dart';
import 'package:jarvis/src/pages/login_page/loginPage.dart';
import 'package:jarvis/src/pages/personal_page/knowledgeTab.dart';
import 'package:jarvis/src/pages/personal_page/personalPage.dart';
import 'package:jarvis/src/pages/promt_page/favouritePromptPage.dart';
import 'package:jarvis/src/pages/register_page/registerPage.dart';
import 'package:jarvis/src/pages/settings_page/settingsPage.dart';
import 'package:jarvis/src/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w300,color: Colors.blue,fontSize: 20)
        ),
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: TextStyle(
          color: Colors.blue
        ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue), // Màu viền khi được chọn
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue.shade300,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(width: 1,color: Colors.blue.shade200)
            ),
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white,
        )
      ),
      home: const LoginPage(title: 'Flutter Demo Home Page'),
      routes: {
        Routes.login: (context)=> const LoginPage(title: "Login"),
        Routes.chat: (context)=> const ChatPage(title: "Chat"),
        Routes.personal: (context) => const PersonalPage(title: "Personal"),
        Routes.personal_knowledgeTab: (context) => const NavigationMenu(initialIndex: 2, pageTab: 1,),
        Routes.settings: (context)=> const SettingsPage(title: "Settings"),
        Routes.home:(context) => const NavigationMenu(),
        Routes.upgrade:(context)=>const UpgradeOptionPage(title: "Price"),
        Routes.favorite:(context)=>const FavouritePromptPage(title: "Favorite"),
        Routes.draftEmail : (context) => const DraftEmailPage(title: "Draft Email"),
      },
    );
  }
}
