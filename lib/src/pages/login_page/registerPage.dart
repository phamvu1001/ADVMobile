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
  String _username = '';
  String _password = '';
  String _retypePassword = '';
  Future<void> register ()
  async {
    await AuthService.signUp(email: "rai637d540@kisoq.com", password: "12345Ab?678");
    backToLogin();
    if(!isValidEmail(_username)){
      //todo: alert
      print(1);
      return;
    }
    if(!isValidPassword(_password)){
      //todo: alert
      print(2);
      return;
    }
    if(_password!=_retypePassword){
      //todo: alert
      print(3);
      return;
    }
  }
  void backToLogin() {
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up with Viras', style: TextStyle(fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset("assets/1.png",
                    height: 120,
                    width: 120,)]
              ) ,
              const Text(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue

                ),

                  "Create your AI journeys"),
              const SizedBox(height: 10),

              TextFormField(
                decoration:  InputDecoration(labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
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
              const SizedBox(height: 10),
              TextFormField(
                decoration:  InputDecoration(labelText: 'Password' ,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),)),
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
              const SizedBox(height: 10),

              TextFormField(
                decoration:  InputDecoration(labelText: 'Retype password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),),),
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
              const SizedBox(height: 10),



              ElevatedButton(
                onPressed: register,
                child: const Text('Sign up'),
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(
                          color: Colors.blue,
                          width: 1.0),
                    ),
                  ),
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        horizontal: 70.0,
                        vertical: 12.0), // Customize padding here
                  ),
                ),
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
                      side: const BorderSide(color: Colors.blue, width: 1),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onPressed: () {
                      print("Sign in with Google");
                    },
                    child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
