import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        style: TextStyle(fontSize: 14),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          labelText: 'Search',
          labelStyle:const TextStyle(fontSize: 14),
          border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(Icons.search),
        ),
        onFieldSubmitted: (value) {
          print('Searching for: $value');
        },
      ),
    );
  }
}