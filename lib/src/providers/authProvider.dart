import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? token;
  String? knowledgeBaseToken;

  void signIn(String token) {
    this.token = token;
    notifyListeners();
  }

  void knowledgeBaseSignIn(String knowledgeBaseToken) {
    this.knowledgeBaseToken = knowledgeBaseToken;
    notifyListeners();
  }

  void signOut() {
    token = null;
    notifyListeners();
  }
}