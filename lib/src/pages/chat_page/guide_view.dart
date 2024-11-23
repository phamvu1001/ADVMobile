import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildGuideView(BuildContext context){
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 240, 240, 240)
    ),
    child: Column(
      children: [
        Row(
          children: [
            Text("Ask anything", style:TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          ],
        ),
        Row(
          children: [
            Text("Type \"/\" to use prompt from library", style:TextStyle(fontSize: 12, color: Colors.black54),),
          ],
        ),
      ],
    ),
  );
}