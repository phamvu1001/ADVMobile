import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/infiniteScrollPromtList.dart';
import 'package:jarvis/src/routes.dart';

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
                  SearchBar(),
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
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
          onFieldSubmitted: (value) {
          print('Searching for: $value');
        },
      ),
    );
  }
}
class PublicPromtView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PublicPromtView();

}

class _PublicPromtView extends State<PublicPromtView> {
  @override
  Widget build(BuildContext context) =>Scaffold(
    body: Padding(
      padding: EdgeInsets.all(10),
      child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: InfinitescrollPromtlist()
      ),
    ),
    floatingActionButton: FloatingActionButton(
      tooltip: 'Increment',
      onPressed: () {  
        Navigator.pushNamed(context, Routes.favorite);
      },
      child: const Icon(Icons.favorite_border),
    ),
  );

}

class PrivatePromtView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PrivatePromtView();

}

class _PrivatePromtView extends State<PrivatePromtView>{
  @override
  Widget build(BuildContext context) =>Scaffold(
    body: Padding(
      padding: EdgeInsets.all(10),
      child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: InfinitescrollPromtlist()
      ),
    ),
    floatingActionButton: FloatingActionButton(
      tooltip: 'Increment',
      onPressed: () {  },
      child: const Icon(Icons.add),
    ),
  );

}