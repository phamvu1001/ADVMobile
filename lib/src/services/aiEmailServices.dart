import 'dart:convert';

import 'package:http/http.dart';
import 'package:jarvis/src/models/chat/assistant_model.dart';

import '../constant/apiURL.dart';


class AIEmailServices {

  static Future<dynamic> generateEmail({
    required String token,
    Assistant? assistant,
    required String email,
    required String action,
    required String idea,
    required String language,
    required String sender,
    required String tone,
    required String length,
    required String formality,
  }) async {

    final body={
      'email': email,
      'action': action,
      'mainIdea': idea,
      'metadata':{
        'context':[],
        'subject':'',
        'sender':sender,
        'receiver':'',
        'style':{
          'length':length,
          'formality':formality,
          'tone':tone
        },
        'language':language
      }
    };
    if(assistant!=null){
      body['assistant']=assistant;
    }
    final response = await post(
      Uri.parse(APIURL.genEmail),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;encoding=utf-8',
      },
      body: jsonEncode(body),
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 201) {
      print(jsonDecode['details']);
    }
    return jsonDecode;
  }

  static Future<dynamic> generateReplyIdeas({
    required String token,
    Assistant? assistant,
    required String email,
    required String language,
    required String sender,
  }) async {
    final body={
      'email': email,
      'action': 'Give me 3 ideas',
      'metadata':{
        'context':[],
        'subject':'',
        'sender':sender,
        'receiver':'',
        'language':language
      }
    };
    if(assistant!=null){
      body['assistant']=assistant;
    }

    final response = await post(
      Uri.parse(APIURL.suggestIdea),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;encoding=utf-8',
      },
      body: jsonEncode(body)
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['details']);
    }

    return jsonDecode;
  }
}