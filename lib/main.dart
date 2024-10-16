import 'package:flutter/material.dart';
import 'package:jarvis/src/navigation.dart';
import 'package:jarvis/src/pages/account_page/upgradeOptionsPage.dart';
import 'package:jarvis/src/pages/chat_page/chatPage.dart';
import 'package:jarvis/src/pages/home_page/homePage.dart';
import 'package:jarvis/src/pages/login_page/loginPage.dart';
import 'package:jarvis/src/pages/personal_page/personalPage.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 183, 129)),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'Flutter Demo Home Page'),
      routes: {
        Routes.login: (context)=> const LoginPage(title: "Login"),
        Routes.chat: (context)=> const ChatPage(title: "Chat"),
        Routes.personal: (context) => const PersonalPage(title: "Personal"),
        Routes.settings: (context)=> const SettingsPage(title: "Settings"),
        Routes.home:(context) => const NavigationMenu(),
        Routes.upgrade:(context)=>const UpgradeOptionPage(title: "Price")
      },
    );
  }
}
