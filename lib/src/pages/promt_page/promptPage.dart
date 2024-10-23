import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/infiniteScrollPromtList.dart';
import 'package:jarvis/src/pages/promt_page/promtDetailPage.dart';
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
  String _selectedCategory= "All";
  @override
  Widget build(BuildContext context) =>Scaffold(
    body: Padding(
      padding: EdgeInsets.all(10),
      child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: Column(
            children: [
              SearchBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IntrinsicWidth(
                      child: DropdownButtonFormField<String>(
                        isExpanded: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                            )
                        ),
                        value: _selectedCategory,
                        items: <String>['All', 'Category 1', 'Categoddddddddry 2']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            alignment: Alignment.centerLeft,
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: InfinitescrollPromtlist()),
            ]
          )
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
          child: Column(
            children: [
              SearchBar(),
              Expanded(child:InfinitescrollPromtlist()),
            ],
          )
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.detail_promt,arguments:{"openMode":OpenMode.create});
      },
      child: const Icon(Icons.add),
    ),
  );

}