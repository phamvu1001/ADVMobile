import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/personal_page/botsTab.dart';
import 'package:jarvis/src/pages/personal_page/knowledgeTab.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
     body: DefaultTabController(
        length: 2,
        child: Column(
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
        // child: Scaffold(
        //   appBar: AppBar(
        //     title: const Text('Personal'),
        //     bottom: const TabBar(
        //       tabs: [
        //         Tab(text: 'Bots'),
        //         Tab(text: 'Knowledge'),
        //       ],
        //     ),
            
        //   ),
        //   body: const TabBarView(
        //     children: [
        //       BotsTab(),
        //       KnowledgeTab(),
        //     ],
        //   ),
        // ),
      )
    );
  }
}