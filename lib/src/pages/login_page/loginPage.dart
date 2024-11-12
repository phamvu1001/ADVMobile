import 'package:flutter/material.dart';
import 'package:jarvis/src/pages/login_page/registerPage.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/routes.dart';
import 'package:jarvis/src/services/authServices.dart';
import 'package:provider/provider.dart';

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

  void _login(AuthProvider authProvider) async {
    await AuthService.loginWithBasicSignIn(
        email: "rai637d540@kisoq.com",
        password: "12345Ab?678",
        onSuccess: (token){
          authProvider.signIn(token);
          Navigator.pushNamed(context, Routes.home);
        });
  }

  void _signWithGoogle() {
    print('sign with google ');
  }

  void _registerBtn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const RegisterPage(title: "Register")));
  }

  void _forgetPassword() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgetPasswordPage()));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to Viras',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset("assets/1.png",
                    height: 120,
                    width: 120,)]
                ) ,


             const SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    gapPadding: 5,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
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
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        gapPadding: 5,
                        borderRadius: BorderRadius.circular(20.0))),
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
                        horizontal: 80.0,
                        vertical: 12.0), // Customize padding here
                  ),
                ),
                onPressed:()=> _login(authProvider),
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Or continue with"),
              Container(
                margin: const EdgeInsets.only(
                    left: 0, top: 10, right: 0, bottom: 20.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 56, vertical: 8),
                    ),
                    onPressed: _signWithGoogle,
                    child:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Image.asset(
                        'assets/google-icon.jpg',
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Google',
                        style: TextStyle(color: Colors.blue),
                      )
                    ])),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                      onPressed: _registerBtn, child: const Text('Register'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
