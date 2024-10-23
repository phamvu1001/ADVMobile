import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/infiniteScrollPromtList.dart';

class FavouritePromptPage extends StatelessWidget {
  const FavouritePromptPage({super.key, required this.title});


  final String title;

  @override
  Widget build(BuildContext context) =>Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body:Padding(
      padding: EdgeInsets.all(10),
      child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: InfinitescrollPromtlist()
      ),
    ),
  );
}
