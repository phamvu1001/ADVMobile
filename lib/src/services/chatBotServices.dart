
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jarvis/src/constant/apiURL.dart';

class ChatBotServices {
  // Get chat bots
  Future<List<dynamic>> getChatBots({required accessToken, required searchText, required selectedType}) async {
    String uri = '${APIURL.knowledgeBaseApiURL}/kb-core/v1/ai-assistant?q=$searchText&order=DESC&order_field=createdAt&limit=20';

    if (selectedType == 'Favourite') {
      uri += '&is_favorite=true';
    }
    else if (selectedType == 'Published') {
      uri += '&is_published=true';
    }

    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'x-jarvis-guid': '361331f8-fc9b-4dfe-a3f7-6d9a1e8b289b',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['data'] as List;

      return items;
    }
    else {
      print('Failed to load chat bots');
      return [];
    }
  }

  // Get chat bot by ID
  Future<dynamic> getChatBot({required kbToken, required assistantId}) async {
    final response = await http.get(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/ai-assistant/$assistantId'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken'
      }
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to load chat bot');
      return {};
    }
  }

  // Create AI Bot
  Future<dynamic> createChatBot({required kbToken, required assistantName, required description}) async {
    final response = await http.post(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/ai-assistant'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'assistantName': assistantName,
          'description': description
        }
      ),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to create AI bot');
      return {};
    }
  }

  // Update AI Bot


  // Delete AI Bot
  Future<dynamic> deleteChatBot({required kbToken, required assistantId}) async {
    final response = await http.delete(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/ai-assistant/$assistantId'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      }
    );

    print(response.statusCode);

    if (response.statusCode == 204 || response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    else {
      print('Failed to delete AI bot');
      return false;
    }
  }

  // Add AI bot to favorite
  Future<dynamic> changeAIBotFavorite({required kbToken, required assistantId}) async {
    final response = await http.post(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/ai-assistant/$assistantId/favorite'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      }
    );

    print(response.statusCode);

    if (response.statusCode == 201) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to add AI bot to favorite');
      return {};
    }
  }

  // Update prompts for AI bot

  // Conversation with created AI bot

  // Add, remove knowledge to AI bot

  // Publish AI chat to Slack, Telegram, Messenger

}