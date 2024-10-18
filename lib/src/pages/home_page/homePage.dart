import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AutomaticKeepAliveClientMixin{
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  _logOut() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: _logOut, child: Text("Log Out")),
            Text("Place LogOut here for testing , move to other places or keep it for test "),


            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  bool get wantKeepAlive => true;
}
