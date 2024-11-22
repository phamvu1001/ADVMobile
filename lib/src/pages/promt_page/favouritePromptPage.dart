import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/infiniteScrollPromtList.dart';
import 'package:provider/provider.dart';

import '../../models/prompt.dart';
import '../../providers/authProvider.dart';
import '../../services/promptServices.dart';
import '../../widgets/searchBar.dart';

class FavouritePromptPage extends StatefulWidget {
  const FavouritePromptPage({super.key, required this.title});


  final String title;

  @override
  State<StatefulWidget> createState() => _FavoritePromptPage();
}

class _FavoritePromptPage extends State<FavouritePromptPage>{
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Padding(
        padding: EdgeInsets.all(10),
        child: ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(scrollbars: false),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
                  child: CustomSearchBar(onTextChange: (value)=>onQueryTextChange(value.toString()),),
                ),
                Expanded(child:InfinitescrollPromtlist(
                  isPublic: true,
                  loadMore: ()=>handleQuery(queryText, authProvider.token!),
                  hasNext: hasNext,
                  promptList: foundPrompt,
                  isLoading: isLoading, isRefresh: isRefresh,))
              ],
            )
        ),
      ),
    );

  }

  void handleQuery(String query, String accessToken) async {
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
        isFavorite: true,
        query: query,
        limit: limit,
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
}
