import 'package:flutter/material.dart';
import 'package:jarvis/src/routes.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) =>Scaffold(
    body:
        Padding(
          padding:const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
              children: [
                SizedBox(height: 20),
                buildTokensCard(context),
                SizedBox(height: 20),
                buildAccountCard(context),
                SizedBox(height: 20),
                buildUpgradeOption(context),
              ],
            ),
        ),
  );

  Widget buildAccountCard(BuildContext context) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Text(
          "Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.lightBlue),
          ),
            child: Row(
                children: [
                  Container(
                    width: 50, height: 50,
                    margin: EdgeInsets.all(5.0), // Khoảng cách giữa viền và nội dung
                    decoration: BoxDecoration(
                      border: Border.all(
                      width: 0.5, // Độ dày của viền
                    ),
                    borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.person_outline_rounded),
                  ),
                  Container(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "John Daw",
                        textAlign:TextAlign.left,
                      ),
                      const Text(
                          "johndaw@gmail.com",
                          textAlign:TextAlign.left
                      ),
                    ],
                  ),),

                ],
              ),
            ),
    ],
  );

  Widget buildTokensCard(BuildContext context) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Token Usage",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      Container(
        padding:const EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.lightBlue),
        ),
        child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today",
                              textAlign:TextAlign.left,
                            ),]),),
                    Expanded(
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Total",
                              textAlign:TextAlign.left,
                            ),]),),
                  ],
                ),
                SizedBox(height: 5),
                LinearProgressIndicator(
                  value: 0.5,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "25",
                            textAlign:TextAlign.left,
                    ),]),),
                    Expanded(
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "50",
                              textAlign:TextAlign.left,
                            ),]),),
                      ],
                ),
              ],
            ),),
          ],
  );

  Widget buildUpgradeOption(BuildContext context) => Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.lightBlue),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sunny),
            Text(
              "Basic",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ) ,
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, Routes.upgrade);
              },
              icon: const Icon(Icons.upgrade_sharp),
              label: const Text('Upgrade'),
            ),
            SizedBox(width: 20),
            ElevatedButton.icon(
              onPressed: () {
              },
              icon: const Icon(Icons.cancel_presentation_outlined),
              label: const Text('Cancel'),
            ),
          ]
        ),
      ],
    ),
  );


}

