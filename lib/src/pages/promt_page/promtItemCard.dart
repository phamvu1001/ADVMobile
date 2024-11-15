import 'package:flutter/material.dart';
import 'package:jarvis/src/models/prompt.dart';

class PromtItemCard extends StatelessWidget {
  const PromtItemCard({
    super.key,
    required this.prompt,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteChange,
    this.onDelete,
    this.onUpdate,
  });

  final VoidCallback onTap;
  final PromptModel prompt;
  final bool isFavorite;
  final VoidCallback onFavoriteChange;
  final onDelete;
  final onUpdate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Card(
        color: Colors.blue.shade50,
        shadowColor: Colors.blueAccent,
        child: ListTile(
          leading: Icon(Icons.public),
          title: Text(prompt.title!),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(prompt.isPublic==true)IconButton(
                icon: Icon(prompt.isFavorite!?Icons.favorite:Icons.favorite_border,color: Colors.red,),
                onPressed: onFavoriteChange,
              ),
              if(prompt.isPublic==false)IconButton(
                icon: Icon(Icons.delete),
                onPressed:onDelete,
              ),
              if(prompt.isPublic==false)IconButton(
                icon: Icon(Icons.mode_edit_outlined),
                onPressed: onUpdate,
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}