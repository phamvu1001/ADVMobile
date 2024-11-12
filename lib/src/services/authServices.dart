import 'dart:convert';

import 'package:http/http.dart';
import 'package:jarvis/src/constant/apiURL.dart';

class AuthService{
  static Future<void> loginWithBasicSignIn({required String email, required String password, required Function(String) onSuccess,})async {
    final response = await post(
      Uri.parse(APIURL.signIn),
      body: {
        'email': email,
        'password': password,
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    final String token = jsonDecode['token']["accessToken"];
    await onSuccess(token);
  }

  static loginWithGoogleSignIn(){

  }

  static Future<void> signUp({required String email, required String password})async {
    final response = await post(
      Uri.parse(APIURL.signUp),
      body: {
        "email": email,
        "password": password,
        "username": "null",
      },
    );
    print(APIURL.signUp);
    print(email);
    print(password);
    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 201) {
      throw Exception(jsonDecode['details']);
    }
  }
}