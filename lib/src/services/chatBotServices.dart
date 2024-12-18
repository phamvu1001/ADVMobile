
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
  Future<dynamic> updateChatBot({required kbToken, required assistantId, required assistantName, required description, required instructions}) async {
    final response = await http.patch(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/ai-assistant/$assistantId'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'assistantName': assistantName,
          'description': description,
          'instructions': instructions
        }
      ),
    );

    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to update AI bot');
      return {};
    }
  }

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


  // Chat with created AI bot
  Future<dynamic> chatWithBot({required kbToken, required assistantId, required openAiThreadIdPlay, required message, required additionalInstructions}) async {
    final response = await http.post(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/ai-assistant/$assistantId/ask'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'message': message,
          'openAiThreadId': openAiThreadIdPlay,
          'additionalInstructions': additionalInstructions
        }
      ),
    );

    print('chatWithBot method response status code: ${response.statusCode}');
    print('chatWithBot method response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = response.body;
      return data;
    }
    else {
      print('Failed to chat with bot');
      return '';
    }
  }

  // Get messages of thread
  Future<dynamic> getMessagesOfThread({required kbToken, required openAiThreadIdPlay}) async {
    final response = await http.get(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/ai-assistant/thread/$openAiThreadIdPlay/messages'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      }
    );

    print('getMessagesOfThread method response status code: ${response.statusCode}');
    print('getMessagesOfThread method response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to get messages of thread');
      return {};
    }
  }

  // Add, remove knowledge to AI bot

  // Publish AI chat to Slack, Telegram, Messenger
  Future<List<dynamic>> getConfigurations({required kbToken, required assistantId}) async {
    final response = await http.get(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/bot-integration/$assistantId/configurations'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      }
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data as List;
    }
    else {
      print('Failed to get configurations');
      return [];
    }
  }

  Future<dynamic> verifyTelegramBotConfigure({required kbToken, required botToken}) async {
    final response = await http.post(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/bot-integration/telegram/validation'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      },
      body: json.encode(
        {
          'botToken': botToken
        }
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to verify telegram bot configuration');
      return {};
    }
  }

  Future<dynamic> publishTelegramBot({required kbToken, required botToken, required assistantId}) async {
    final response = await http.post(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/bot-integration/telegram/publish/$assistantId'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      },
      body: json.encode(
        {
          'botToken': botToken
        }
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to verify telegram bot configuration');
      return {};
    }
  }

  Future<dynamic> verifySlackBotConfigure({required kbToken, required botToken, required clientId, required clientSecret, required signingSecret}) async {
    final response = await http.post(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/bot-integration/slack/validation'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      },
      body: json.encode(
        {
          'botToken': botToken,
          'clientId': clientId,
          'clientSecret': clientSecret,
          'signingSecret': signingSecret
        }
      ),
    );

    if (response.statusCode == 200) {
      // final data = json.decode(response.body);

      // return data;
      return true;
    }
    else {
      print('Failed to verify slack bot configuration');
      return false;
    }
  }

  Future<dynamic> publishSlackBot({required kbToken, required botToken, required clientId, required clientSecret, required signingSecret, required assistantId}) async {
    final response = await http.post(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/bot-integration/slack/publish/$assistantId'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      },
      body: json.encode(
        {
          'botToken': botToken,
          'clientId': clientId,
          'clientSecret': clientSecret,
          'signingSecret': signingSecret
        }
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to verify slack bot configuration');
      return {};
    }
  }

  Future<dynamic> verifyMessengerBotConfiguration({required kbToken, required botToken, required pageId, required appSecret}) async {
    final response = await http.post(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/bot-integration/messenger/validation'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      },
      body: json.encode(
        {
          'botToken': botToken,
          'pageId': pageId,
          'appSecret': appSecret
        }
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to verify messenger bot configuration');
      return {};
    }
  }

  Future<dynamic> publishMessengerBot({required kbToken, required botToken, required pageId, required appSecret, required assistantId}) async {
    final response = await http.post(
      Uri.parse('${APIURL.knowledgeBaseApiURL}/kb-core/v1/bot-integration/messenger/publish/$assistantId'),
      headers: {
        'x-jarvis-guid': 'a153d8df-ee7d-4ac3-943e-882726700f9b',
        'Authorization': 'Bearer $kbToken',
      },
      body: json.encode(
        {
          'botToken': botToken,
          'pageId': pageId,
          'appSecret': appSecret
        }
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    }
    else {
      print('Failed to verify messenger bot configuration');
      return {};
    }
  }

}