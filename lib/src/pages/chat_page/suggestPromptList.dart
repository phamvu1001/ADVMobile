import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/src/models/prompt.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/services/promptServices.dart';
import 'package:provider/provider.dart';

class SuggestPromptList extends StatefulWidget {
  SuggestPromptList({super.key, required this.onSelectedItem, required this.queryPrompt, required this.accessToken});
  final onSelectedItem;
  String queryPrompt;
  String accessToken;
  @override
  _SuggestPromptListState createState() => _SuggestPromptListState();
}

class _SuggestPromptListState extends State<SuggestPromptList> {
  List<PromptModel> suggestions = [ ];
  Timer? _debounce;
  ScrollController _scrollController = ScrollController(initialScrollOffset: -50);
  bool hasNext=true;
  bool isLoading=false;
  int limit=20;
  int offset=0;

  void _onTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 300), () {
      setState(() {
        hasNext=true;
        isLoading=false;
        offset=0;
        suggestions.clear();
      });
      handleQuery(widget.queryPrompt, widget.accessToken);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.maxScrollExtent<=0 &&!isLoading){
        handleQuery(widget.queryPrompt, widget.accessToken);
      }
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent &&hasNext&&!isLoading) {
        handleQuery(widget.queryPrompt, widget.accessToken);
      }
    });
  }

  @override
  void didUpdateWidget(covariant SuggestPromptList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.queryPrompt != oldWidget.queryPrompt) {
      _onTextChanged(widget.queryPrompt);
    }
  }
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Container(
      height: 150,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: suggestions.length + 1,
        itemBuilder: (context, index) {
          if (index == suggestions.length) {
            if(hasNext) {
              return Center(child: CircularProgressIndicator(color: Colors.blue,));
            }else{
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("All shown")
                ],
              );
            }
          }
          return  ListTile(title: Text(suggestions[index].title!, style: TextStyle(fontSize: 14),),
            onTap:()=> widget.onSelectedItem(suggestions[index].content),
          );
        },
      ),
    );
  }

  void handleQuery(String? query, String accessToken) async {
    setState(() {
      isLoading = true;
    });
    List<PromptModel> _searchPrompt = await PromptServices().getPrompt(
        onSucess: (hasNext) {
          offset += limit;
          setState(() {
            this.hasNext = hasNext;
          });
        },
        limit: limit,
        query: query,
        offset: offset,
        accessToken: accessToken);

    setState(() {
      suggestions.addAll(_searchPrompt);
      isLoading = false;
    });
  }
}