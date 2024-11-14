import 'package:jarvis/src/models/chat/assistant_model.dart';

class Conversation {
  String id;
  List<Message> messages = [];

  Conversation({
    required this.id,
    required List<Message> messages,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}

class Message {
  final String role;
  final String content;
  final Assistant assistant;

  Message({
    required this.role,
    required this.content,
    required this.assistant,
  });

  
  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      'assistant': assistant.toJson(),
    };
  }
}

