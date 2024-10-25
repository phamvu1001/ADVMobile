import 'package:flutter/material.dart';
import 'package:jarvis/src/routes.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key} );



  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

  class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();


  void _ForgetPassword() {
    //Navigator.pushNamed(context, Routes.home);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password', style: TextStyle(fontWeight: FontWeight.w400),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const Text("Enter your email" ,
              style: TextStyle(
                fontSize: 18,

              ),),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Enter your email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },

              ),

              SizedBox(height: 40,),

              ElevatedButton(
                onPressed: _ForgetPassword,
                child: const Text('Confirm'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
