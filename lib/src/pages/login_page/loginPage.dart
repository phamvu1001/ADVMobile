import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/register_page/registerPage.dart';
import 'package:jarvis/src/routes.dart';

import 'forgetPasswordPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _login() {
    Navigator.pushNamed(context, Routes.home);

  }
void _registerBtn ()
  {
  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage(title: "Register")));
}
  void _forgetPassword() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Jarvis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 20.0),
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

              const Text("Continue with"),
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
              const SizedBox(height: 20),
              TextButton(
                  onPressed: _forgetPassword,
                  child: const Text('Forgot password ?')),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                      onPressed:
                        _registerBtn ,

                      child: const Text('Register'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
