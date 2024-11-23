import 'package:flutter/material.dart';
import 'package:jarvis/src/routes.dart';

import '../../helpers/string_helper.dart';
import '../../services/authServices.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _retypePassword = TextEditingController();

  void showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> register() async {
    /*sample password : 0dcj9nGfzueon7f   */

    if (!isValidEmail(_email.text)) {
      return;
    }
    if (!isValidPassword(_password.text)) {
      showAlertDialog('Password is too weak', "");
      return;
    }
    if (_password.text != _retypePassword.text) {
      showAlertDialog('Password mismatch', 'Passwords do not match');
      print(3);
      return;
    }
    print("Email: ${_email.text}");
    print("Password: ${_password.text}");
    print("Username: ${_username.text}");
    bool isSuccess = await AuthService.signUp(
        email: _email.text, password: _password.text, username: _username.text);
    // bool isSuccess = await AuthService.signUp(
    //     email: "duck2598@dotvu.net", password:  "12345Ab?678*", username: "daffwfwe");
    if (isSuccess == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Press OK to back to Login Page"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: TextButton(child: const Text('OK'), onPressed: () {
                  backToLogin();
                },),
              ),
            ],
          );
        },
      );
    } else {
      showAlertDialog("Fail", "Sign up is not successful");
    }
  }

  void backToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up with Viras',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  "assets/1.png",
                  height: 120,
                  width: 120,
                )
              ]),
              const Text(
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                  "Create your AI journeys"),
              const SizedBox(height: 10),
              TextFormField(
                controller: _username,
                decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username.text = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email.text = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password.text = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _retypePassword,
                decoration: InputDecoration(
                  labelText: 'Retype password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value != _password) return 'Is not similar to password';
                  return null;
                },
                onSaved: (value) {
                  _retypePassword.text = value!;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: register,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(color: Colors.blue, width: 1.0),
                    ),
                  ),
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        horizontal: 70.0,
                        vertical: 12.0), // Customize padding here
                  ),
                ),
                child: const Text('Sign up'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have account ?"),
                  TextButton(
                      onPressed: backToLogin, child: const Text("Login")),
                ],
              ),
              const Text("Or"),
              Container(
                margin: const EdgeInsets.only(
                    left: 0, top: 20.0, right: 0, bottom: 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue, width: 1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    onPressed: () {
                      print("Sign in with Google");
                    },
                    child:
                    Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Image.asset(
                        'assets/google-icon.jpg',
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.blue),
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
