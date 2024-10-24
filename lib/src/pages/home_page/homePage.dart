import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:10, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints.expand(height: 100),
            decoration: BoxDecoration(color: Colors.transparent),
            child: Image.asset(
              'assets/hello.png',
              fit: BoxFit.contain,
          )),
          Row(
            children: [
              Text("Hi, good afternoon!", style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            ],
          ),
          Row(
            children: [
              Text("I am Jarvis, your personal assistant!", style:TextStyle(fontSize: 14),),
            ],
          ),
          Row(
            children: [
              Text("Here are some of my amazing powers.", style:TextStyle(fontSize: 14),),
            ],
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 240, 240, 240)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Writing an email", style:TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("with different actions", style:TextStyle(fontSize: 14, color: Colors.black54),),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 240, 240, 240)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Chat with assistant", style:TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("from ", style:TextStyle(fontSize: 14, color: Colors.black54),),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 240, 240, 240)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Build your own chatbot", style:TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("with different actions", style:TextStyle(fontSize: 14, color: Colors.black54),),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 240, 240, 240)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Explore promt library", style:TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("with different actions", style:TextStyle(fontSize: 14, color: Colors.black54),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

