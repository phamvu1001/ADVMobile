


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/src/models/prompt.dart';
import 'package:jarvis/src/pages/promt_page/promtPage.dart';
import 'package:jarvis/src/services/promptServices.dart';
import 'package:provider/provider.dart';

import '../../providers/authProvider.dart';
import '../../widgets/searchBar.dart';
import 'PrivatePromtDialog.dart';
import 'infiniteScrollPromtList.dart';

class PrivatePromtView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PrivatePromtView();
}

class _PrivatePromtView extends State<PrivatePromtView>{
  List<PromptModel> foundPrompt=[];
  int limit=20;
  int offset=0;
  bool hasNext=true;
  bool isLoading=false;
  bool isRefresh=false;
  String queryText='';
  Timer? _typingTimer;
  final debounceDuration = Duration(milliseconds: 300);

  void onCreateNew(){
    offset = 0;
    setState(() {
      foundPrompt.clear();
      isRefresh=true;
      hasNext = true;
      isLoading=false;
    });
  }

  void onUpdate(int index, String accessToken, PromptModel updatePrompt){
    PromptServices().updatePromt(updatePromt: updatePrompt, accessToken: accessToken);
    setState(() {
      foundPrompt[index].title=updatePrompt.title;
      foundPrompt[index].content=updatePrompt.content;
    });
  }
  @override
  Widget build(BuildContext context){
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Padding(
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
                  isRefresh:isRefresh,
                  isPublic: false,
                  loadMore:()=> handleQuery(queryText, authProvider.token!),
                  hasNext: hasNext,
                  onDelete: (int index, String token)=>onDeletePrivatePrompt(index, token),
                  onUpdate:onUpdate,
                  promptList: foundPrompt,
                  isLoading: isLoading,)),
              ],
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context)=> PrivatePromptDialog(openMode: OpenMode.create, onCreate: onCreateNew,));
        },
        child: const Icon(Icons.add),
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
        isPublic: false,
        limit: limit,
        query: query,
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
  void onDeletePrivatePrompt (int index, String token){
    PromptServices().deletePrompt(id: foundPrompt[index].id!, accessToken: token);
    setState(() {
      foundPrompt.removeAt(index);
    });
  }
}