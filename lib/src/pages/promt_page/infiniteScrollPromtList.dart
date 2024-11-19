
import 'package:flutter/material.dart';
import 'package:jarvis/src/models/prompt.dart';
import 'package:jarvis/src/pages/promt_page/privatePromtDialog.dart';
import 'package:jarvis/src/pages/promt_page/promtPage.dart';
import 'package:jarvis/src/pages/promt_page/publicPromtDialog.dart';
import 'package:jarvis/src/pages/promt_page/promtItemCard.dart';
import 'package:jarvis/src/services/promptServices.dart';
import 'package:provider/provider.dart';

import '../../providers/authProvider.dart';

class InfinitescrollPromtlist extends StatefulWidget {
  InfinitescrollPromtlist({super.key,required this.isPublic,required this.isRefresh,required this.loadMore, required this.hasNext, required this.promptList, required this.isLoading, this.onDelete, this.onUpdate});
  final bool isPublic;
  bool hasNext;
  bool isLoading;
  bool isRefresh;
  final loadMore;
  final onDelete;
  final onUpdate;

  List<PromptModel> promptList;
  @override
  _InfiniteScrollListState createState() => _InfiniteScrollListState();
}

class _InfiniteScrollListState extends State<InfinitescrollPromtlist> {
  ScrollController _scrollController = ScrollController(initialScrollOffset: -50);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.maxScrollExtent<=0 &&!widget.isLoading){
        widget.loadMore();
      }
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent && widget.hasNext&&!widget.isLoading) {
        widget.loadMore();
      }
    });
  }

  @override
  void didUpdateWidget(covariant InfinitescrollPromtlist oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.isRefresh==true && oldWidget.isRefresh==false){
      _scrollController.jumpTo(-50);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onFavoriteChange(int index,String token){
    bool isFav=widget.promptList[index].isFavorite??false;
    setState(() {
      widget.promptList[index].isFavorite=!isFav;
    });
    if(!isFav){
      PromptServices().addPromptToFavorite(id: widget.promptList[index].id!, accessToken: token);
    }else if(widget.promptList[index].isFavorite==false){
      PromptServices().removePromptFromFavorite(id: widget.promptList[index].id!, accessToken: token);
    }
  }

  void onPromptCardTap(BuildContext context, int index){
    showDialog(context: context, builder: (context)=>
      widget.isPublic?PublicPromptDialog(prompt:widget.promptList[index]):
                      PrivatePromptDialog(openMode: OpenMode.view, prompt: widget.promptList[index],));

  }

  void onUpdateAction(BuildContext context, int index, String token){
    showDialog(context: context, builder: (context)=>
        PrivatePromptDialog(
          openMode: OpenMode.edit,
          onUpdate: (PromptModel updated)=>widget.onUpdate(index, token, updated),
          prompt: widget.promptList[index],));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        controller: _scrollController,
        itemCount: widget.promptList.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.promptList.length) {
            if(widget.hasNext) {
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
          return  PromtItemCard(
              prompt: widget.promptList[index],
              onTap: ()=>onPromptCardTap(context,index),
              isFavorite: true,
              onFavoriteChange: ()=>onFavoriteChange(index,authProvider.token!),
              onDelete:()=> widget.isPublic?null:widget.onDelete(index,authProvider.token),
              onUpdate: ()=> onUpdateAction(context, index, authProvider.token!),
          );
        },
      ),
    );
  }
}
