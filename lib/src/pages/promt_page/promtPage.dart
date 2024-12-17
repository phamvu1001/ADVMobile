import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/infiniteScrollPromtList.dart';
import 'package:jarvis/src/pages/promt_page/privatePromtDialog.dart';
import 'package:jarvis/src/routes.dart';
import '../../widgets/searchBar.dart';

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

class PublicPromtView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PublicPromtView();

}

class _PublicPromtView extends State<PublicPromtView> {
  String _selectedCategory= "All";
  List<String> _categoryList=["Cat 1", "Cat 2","Categorry 3","All"];
  @override
  Widget build(BuildContext context) =>Scaffold(
    body: Padding(
      padding: EdgeInsets.all(10),
      child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
                child: CustomSearchBar(),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: IntrinsicWidth(
                      child: DropdownButtonFormField2<String>(
                        isExpanded: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                        value: _selectedCategory,
                        hint: const Text(
                          'Select Category',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: _categoryList.map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory=value!;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: InfinitescrollPromtlist(isPublic: true,)),
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
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
                child: CustomSearchBar(),
              ),
              Expanded(child:InfinitescrollPromtlist(isPublic: false,)),
            ],
          )
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        showDialog(context: context, builder: (context)=> PrivatePromptDialog(openMode: OpenMode.create,));
      },
      child: const Icon(Icons.add),
    ),
  );

}