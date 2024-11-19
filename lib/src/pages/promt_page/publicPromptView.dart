

import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/src/constant/category.dart';
import 'package:provider/provider.dart';

import '../../models/prompt.dart';
import '../../providers/authProvider.dart';
import '../../routes.dart';
import '../../services/promptServices.dart';
import '../../widgets/searchBar.dart';
import 'infiniteScrollPromtList.dart';

class PublicPromtView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PublicPromtView();

}

class _PublicPromtView extends State<PublicPromtView> {
  String? _selectedCategory= null;
  late List<PromptModel> foundPrompt=[];
  int limit=20;
  int offset=0;
  bool hasNext=true;
  bool isLoading=false;
  bool isRefresh=false;
  String queryText='';
  Timer? _typingTimer;
  final debounceDuration = Duration(milliseconds: 300);




  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(scrollbars: false),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, bottom: 5, right: 15),
                    child: CustomSearchBar(onTextChange: (value) =>onQueryTextChange(value.toString()),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: IntrinsicWidth(
                      child: DropdownButtonFormField2<String>(
                        isExpanded: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0),
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
                        hint: const Text('Select Category',style: TextStyle(fontSize: 14),),
                        items: category.map((item) =>
                            DropdownMenuItem<String>(
                              value: item["value"],
                              child: Text(item["name"]!, style: const TextStyle(fontSize: 14,),),
                            )).toList(),
                        onChanged: (value) =>onSlectedCategoryChange(value.toString()),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(Icons.arrow_drop_down, color: Colors.black45,),iconSize: 24,),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: InfinitescrollPromtlist(isPublic: true,
                    loadMore: () => handleQuery(queryText, _selectedCategory, authProvider.token!),
                    hasNext: hasNext,
                    promptList: foundPrompt,
                    isLoading: isLoading, isRefresh: isRefresh,)),
                ]
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Favorite',
        onPressed: () {
          Navigator.pushNamed(context, Routes.favorite);
        },
        child: const Icon(Icons.favorite_border),
      ),
    );
  }

    void handleQuery(String? query,String? category, String accessToken) async {
      setState(() {
        isLoading=true;
      });
      List<PromptModel> _searchPrompt = await PromptServices().getPrompt(
          onSucess: (hasNext) {
            offset+=limit;
            setState(() {
              this.hasNext=hasNext;
            });
          },
          isPublic: true,
          limit: limit,
          query: query,
          category: category,
          offset: offset,
          accessToken: accessToken);

      setState(() {
        foundPrompt.addAll(_searchPrompt);
        isLoading=false;
        isRefresh=false;
      });
  }

  void onQueryTextChange(String text){
    _typingTimer?.cancel();
    _typingTimer = Timer(debounceDuration, () {
      if(text.toString().trim()==queryText){
        return;
      }
      offset = 0;
      queryText = text;
      setState(() {
        foundPrompt.clear();
        isRefresh=true;
        hasNext = true;
        isLoading=false;
      });
    });
  }

  void onSlectedCategoryChange(String value) {
    if(value.toString().trim()==queryText){
      return;
    }
    offset = 0;
    setState(() {
      isRefresh=true;
      _selectedCategory=value;
      hasNext = true;
      foundPrompt.clear();
      isLoading=false;
    });
  }
}
