import 'package:flutter/material.dart';
import 'package:jarvis/src/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) =>Scaffold(
    body: Center(
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
        ),
        child: const Text('Login'),
        onPressed:()=> {
          Navigator.pushNamed(context, Routes.home)
        },
      ),
    ) ,
  );


}

