import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? token;

  void signIn(String token) {
    this.token = token;
    notifyListeners();
  }

  void signOut() {
    token = null;
    notifyListeners();
  }
}