import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jarvis/src/constant/apiURL.dart';
import 'package:jarvis/src/navigation.dart';
import 'package:jarvis/src/pages/account_page/upgradeOptionsPage.dart';
import 'package:jarvis/src/pages/chat_page/chatPage.dart';
import 'package:jarvis/src/pages/chat_page/conversationPage.dart';
import 'package:jarvis/src/pages/draft_email_page/draftEmail.dart';
import 'package:jarvis/src/pages/home_page/homePage.dart';
import 'package:jarvis/src/pages/login_page/TokenManager.dart';
import 'package:jarvis/src/pages/login_page/loginPage.dart';
import 'package:jarvis/src/pages/personal_page/knowledgeTab.dart';
import 'package:jarvis/src/pages/personal_page/personalPage.dart';
import 'package:jarvis/src/pages/promt_page/favouritePromptPage.dart';
import 'package:jarvis/src/pages/login_page/registerPage.dart';
import 'package:jarvis/src/pages/settings_page/settingsPage.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/routes.dart';
import 'package:jarvis/src/services/authServices.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    void startTokenRefreshTimer(AuthProvider authProvider) {
      Timer.periodic(const Duration(minutes: 1), (Timer t) async {
        print('start token refresh timer');
        var isValid = await AuthService.ensureTokenIsValid(authProvider: authProvider);

        if (!isValid) {
          t.cancel();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Session Expired"),
                content: const Text("Please login again"),
                actions: [
                  TextButton(
                    onPressed: () => {
                      Navigator.pop(context),
                     Navigator.pushNamed(context, Routes.login)
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    }
    void _login(AuthProvider authProvider) async {
      await AuthService.loginWithBasicSignIn(
          email: "rai637d540@kisoq.com",
          password: "12345Ab?678",
          onSuccess: (token){
            authProvider.signIn(token);
          });
      startTokenRefreshTimer(authProvider);
    }
    AuthProvider authProvider;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) {
            authProvider = AuthProvider();
            TokenManager.getToken().then((token) {
              if (token != null) {
                print('Token Manager token: $token');
                authProvider.signIn(token);
                AuthService.signInKnowledgeBaseFromJarvis(token).then((knowledgeBaseToken) {
                  authProvider.knowledgeBaseSignIn(knowledgeBaseToken);
                });
              }
            });

            return authProvider;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            titleTextStyle: TextStyle(fontWeight: FontWeight.w400,color: Colors.blue,fontSize: 20)
          ),
          scaffoldBackgroundColor: Colors.white,
          dialogBackgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              floatingLabelStyle: TextStyle(
                color: Colors.blue,
                fontSize: 14,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue), // Màu viền khi được chọn
            ),
            hintStyle: TextStyle(
              fontSize: 14,
            )
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.black,
            selectionColor: Colors.blue.shade100,
            selectionHandleColor: Colors.blue,
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
        home: FutureBuilder<bool>(
          future: AuthService.ensureTokenIsValid(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data == true) {
              AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
              startTokenRefreshTimer(authProvider);
              return const NavigationMenu(initialIndex: 0,);

            } else {
              return const LoginPage(title: 'Login');
            }
          },
        ),
        routes: {
          Routes.login: (context)=> const LoginPage(title: "Login"),
          // Routes.chat: (context) => const ChatPage(title: "Chat"),
          Routes.chat: (context) => const NavigationMenu(initialIndex: 1),
          Routes.personal: (context) => const PersonalPage(title: "Personal"),
          Routes.personal_knowledgeTab: (context) => const NavigationMenu(initialIndex: 2, pageTab: 1,),
          Routes.knowledge_page: (context) => const NavigationMenu(initialIndex: 5),
          Routes.settings: (context)=> const SettingsPage(title: "Settings"),
          Routes.home:(context) => const NavigationMenu(initialIndex: 0,),
          Routes.upgrade:(context)=>const UpgradeOptionPage(title: "Price"),
          Routes.favorite:(context)=>const FavouritePromptPage(title: "Favorite"),
          Routes.draftEmail : (context) => const DraftEmailPage(title: "Draft Email"),
          Routes.newchat: (context)=> const ConversationPage(),
        },
      ),
    );
  }
}
