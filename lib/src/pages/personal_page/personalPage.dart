import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/personal_page/botsTab.dart';
import 'package:jarvis/src/pages/personal_page/knowledgeTab.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key, required this.title, this.tab = 0});

  final String title;
  final int tab;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     body: DefaultTabController(
        length: 2,
        initialIndex: tab,
        child: const Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Bots'),
                Tab(text: 'Knowledge'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BotsTab(),
                  KnowledgeTab(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}