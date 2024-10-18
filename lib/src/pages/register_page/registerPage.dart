import 'package:flutter/material.dart';
import 'package:jarvis/src/routes.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _retypePassword = '';
  void register ()
  {
    // validate
    print("Register succesfully");
  }
  void backToLogin() {
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up with Jarvis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                style: TextStyle(
                  fontSize: 20,

                ),

                  "Create your AI journeys"),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Retype password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'Please enter your password';
                  }
                  if (value != _password) return 'Is not similar to password';
                  return null;
                },
                onSaved: (value) {
                  _retypePassword = value!;
                },
              ),
              const SizedBox(height: 20),



              ElevatedButton(
                onPressed: register,
                child: const Text('Sign up'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have account ?") ,
                  TextButton(
                      onPressed: backToLogin,
                      child: const Text(
                          "Login")),
                ],
              ),
              Text("Or"),
              Container(
                margin: EdgeInsets.only(left: 0, top: 20.0, right: 0, bottom: 0),
                child:
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onPressed: () {
                      print("Sign in with Google");
                    },
                    child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Image.asset(
                        'lib/assets/google-icon.jpg',
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.black),
                      )
                    ])),
              ),

       
            ],
          ),
        ),
      ),
    );
  }
}
