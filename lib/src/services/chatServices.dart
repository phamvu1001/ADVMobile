import 'dart:convert';

import 'package:highlight/src/mode.dart';
import 'package:jarvis/src/constant/apiURL.dart';
import 'package:http/http.dart' as http;
import 'package:jarvis/src/constant/assistants.dart';

class ChatService {
  Future<List<dynamic>> getConversationHistory(
      {required conversationId,
      required assistantId,
      required accessToken}) async {
    if (conversationId == '') {
      return [];
    }

    final response = await http.get(
      Uri.parse(APIURL.getConversationHistory(conversationId) +
          '?assistantId=$assistantId&assistantModel=dify'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'x-jarvis-guid': '361331f8-fc9b-4dfe-a3f7-6d9a1e8b289b',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List;

      return items;
    } else {
      // Handle error
      print('Failed to load conversation history');
      return [];
    }
  }

  Future<dynamic> getAvailableToken({required accessToken}) async {
    final response = await http.get(
      Uri.parse(APIURL.getUsage),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'x-jarvis-guid': '361331f8-fc9b-4dfe-a3f7-6d9a1e8b289b',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    }
  }

  Future<dynamic> getModelResponse(
      {required query,
      required assistantId,
      required conversation,
      required accessToken}) async {
    final response = await http.post(
      Uri.parse(APIURL.sendMessage),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'content': query,
        'metadata': {'conversation': conversation.toJson()},
        'assistant': Assistants.assistants[assistantId]!.toJson(),
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      // Handle error
      print('Failed to send message');
      return null;
    }
  }
}
