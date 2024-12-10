import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget {
  final onTextChange;
  const CustomSearchBar({super.key, this.onTextChange });
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

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
        onChanged: (value){
          onTextChange(value, authProvider);
        },
      ),
    );
  }
}