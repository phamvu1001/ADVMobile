
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jarvis/src/constant/apiURL.dart';

class ChatBotServices {
  // Get chat bots
  Future<List<dynamic>> getChatBots({required accessToken, required isFavorite, required isPublished}) async {
    final response = await http.get(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/ai-assistant?order=DESC&order_field=createdAt&limit=20&is_favourite=$isFavorite&is_published=$isPublished'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'x-jarvis-guid': '361331f8-fc9b-4dfe-a3f7-6d9a1e8b289b',
      }
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

  // Create AI Bot

  // Update AI Bot

  // Delete AI Bot

  // Update prompts for AI bot

  // Conversation with created AI bot

  // Add, remove knowledge to AI bot

  // Publish AI chat to Slack, Telegram, Messenger

}