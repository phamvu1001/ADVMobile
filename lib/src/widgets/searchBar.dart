import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextFormField(
        style: TextStyle(fontSize: 14),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          labelText: 'Search',
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