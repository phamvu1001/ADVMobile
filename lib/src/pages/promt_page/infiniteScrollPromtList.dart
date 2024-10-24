
import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/privatePromtDialog.dart';
import 'package:jarvis/src/pages/promt_page/promtPage.dart';
import 'package:jarvis/src/pages/promt_page/publicPromtDialog.dart';
import 'package:jarvis/src/pages/promt_page/promtItemCard.dart';

class InfinitescrollPromtlist extends StatefulWidget {
  const InfinitescrollPromtlist({super.key,required this.isPublic});
  final bool isPublic;
  @override
  _InfiniteScrollListState createState() => _InfiniteScrollListState();
}

class _InfiniteScrollListState extends State<InfinitescrollPromtlist> {
  List<int> _data = [];
  int _currentMax = 0;
  bool isFavorite=false;
  bool isEnd=false;
  ScrollController _scrollController = ScrollController(initialScrollOffset: -50);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.maxScrollExtent<=0){
        _loadMoreData();
      }
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent && !isEnd) {
        _loadMoreData();
      }
    });
  }

  Future<void> _loadMoreData() async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      if(_data.length==10){
        isEnd=true;
        return;
      }
      for (int i = _currentMax; i < _currentMax + 10; i++) {
        _data.add(i);
      }
      _currentMax = _data.length;
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _data.length + 1,
        itemBuilder: (context, index) {
          if (index == _data.length) {
            if(!isEnd) {
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
          return  GestureDetector(
            onLongPress: () {
              // Hiển thị menu khi nhấn lâu
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit'),
                          onTap: () {
                            Navigator.pop(context); // Đóng bottom sheet
                            print('Chỉnh sửa item $index');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete'),
                          onTap: () {
                            Navigator.pop(context); // Đóng bottom sheet
                            print('Xoá item $index');
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: PromtItemCard(
                index: index,
                name: "name",
                onTap: (){
                  showDialog(context: context, builder: (context)=> widget.isPublic?PublicPromptDialog():PrivatePromptDialog(openMode: OpenMode.view,));
                },
                isFavorite: isFavorite,
                onFavoriteChange: (){
                  setState(() {
                    isFavorite=!isFavorite;
                  });
                }
            ),
          );
        },
      ),
    );
  }
}
