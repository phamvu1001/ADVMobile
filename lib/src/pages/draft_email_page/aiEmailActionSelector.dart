

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/src/constant/aiEmailAction.dart';
import 'package:jarvis/src/services/aiEmailServices.dart';

class AiEmailActionSelector extends StatefulWidget{

  AiEmailActionSelector({super.key, required this.onSelectionChange, required this.items, required this.title, required this.defaultValue});
  final onSelectionChange;
  final List<Map<String, String>> items;
  final String title;
  final String defaultValue;
  @override
  State<StatefulWidget> createState() => _AiEmailActionSelector();

}

class _AiEmailActionSelector extends State<AiEmailActionSelector>{
  String _selectedChoice="";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
        "  "+widget.title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      Wrap(
        children: widget.items.map((option) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilterChip(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.blue, width: 0.5)
              ),
              label: Text(option['label']!, style: TextStyle(color: _selectedChoice==option['value']?Colors.white:Colors.blue),),
              selected: _selectedChoice == option['value'],
              selectedColor: Colors.blue,
              showCheckmark: false,
              onSelected: (bool selected) {
                setState(() {
                  _selectedChoice = (selected ? option['value'] : widget.defaultValue)!;
                });
                widget.onSelectionChange(_selectedChoice);
              },
            ),
          );
        }).toList(),
      ),
    ],);
  }

}