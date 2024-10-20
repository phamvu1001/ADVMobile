
import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/promt_page/promtDialog.dart';

class InfinitescrollPromtlist extends StatefulWidget {
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
              return Center(child: CircularProgressIndicator());
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
            child: ListTile(
              leading: Icon(Icons.public),
              title: Text("Prompt ${_data[index]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min, // Để giữ cho Row có kích thước nhỏ nhất có thể
                children: <Widget>[
                  IconButton(
                    icon: Icon(isFavorite?Icons.favorite:Icons.favorite_border), // Icon cho button đầu tiên
                    onPressed: () {
                      // Xử lý khi nhấn vào button edit
                      setState(() {
                        isFavorite=!isFavorite;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete), // Icon cho button thứ hai
                    onPressed: () {
                      // Xử lý khi nhấn vào button delete
                      print('Delete button pressed');
                    },
                  ),
                ],
              ),
              onTap: () {
                // Xử lý khi bấm vào ListTile
                showDialog(context: context, builder: (context)=> PromptDialog());
              },
            ),
          );
        },
      ),
    );
  }
}
