import 'package:flutter/material.dart';

class PromtItemCard extends StatelessWidget {
  const PromtItemCard({
    super.key,
    required this.index,
    required this.name,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteChange,
  });
  final VoidCallback onTap;
  final int index;
  final String name;
  final bool isFavorite;
  final VoidCallback onFavoriteChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Card(
        color: Color.fromRGBO(245, 245, 255,1),
        shadowColor: Colors.blueAccent,
        child: ListTile(
          leading: Icon(Icons.public),
          title: Text("Prompt ${index}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min, // Để giữ cho Row có kích thước nhỏ nhất có thể
            children: <Widget>[
              IconButton(
                icon: Icon(isFavorite?Icons.favorite:Icons.favorite_border,color: Colors.red,), // Icon cho button đầu tiên
                onPressed: onFavoriteChange,
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
          onTap: onTap,
        ),
      ),
    );
  }
}