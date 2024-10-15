import 'package:flutter/material.dart';
import 'package:jarvis/src/routes.dart';

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
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();
    //
    //   print('Đăng nhập với tên người dùng: $_username và mật khẩu: $_password');
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Đăng nhập thành công!')),
    //   );
    // }
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
              Text("Continue with"),
              Row(children: [
                ElevatedButton(
                  child: Text("Login"),
                  onPressed: () {
                    print("In login section");
                  },
                ),
                ElevatedButton(
                  child: Text("Register"),
                  onPressed: () {
                    print("In login section");
                  },
                )
              ]),
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
                  onPressed: () {
                    print("Forget password section");
                  },
                  child: const Text('Forget password')),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              Row(
                children: [
                  Text("Don't have an account"),
                  TextButton(
                      onPressed: () {
                        print("Register");
                      },
                      child: Text('Register'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
