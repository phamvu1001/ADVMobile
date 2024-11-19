import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/infiniteScrollPromtList.dart';
import 'package:jarvis/src/pages/promt_page/privatePromptView.dart';
import 'package:jarvis/src/pages/promt_page/publicPromptView.dart';
import 'package:jarvis/src/routes.dart';
import '../../widgets/searchBar.dart';
import 'PrivatePromtDialog.dart';

enum OpenMode{edit, view, create}

class PromptManagementPage extends StatelessWidget {
  const PromptManagementPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) =>Scaffold(
      body: DefaultTabController(
        length: 2,
        child:
              Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Public'),
                      Tab(text: 'Private'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        PublicPromtView(),
                        PrivatePromtView(),
                      ],
                    ),
                  ),
                ],
          )
      ),
   );
}
