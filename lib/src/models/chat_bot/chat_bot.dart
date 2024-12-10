class ChatBot {
  String id = '';
  String assistantName = '';
  String description = '';
  String openAiAssistantId = '';
  String instructions = '';
  String openAiThreadIdPlay = '';
  bool isDefault = true;
  bool isFavorite = false;
  bool isPublished = false;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy = '';
  String updatedBy = '';

  ChatBot({
    required this.id,
    required this.assistantName,
    required this.description,
    required this.openAiAssistantId,
    required this.instructions,
    required this.openAiThreadIdPlay,
    required this.createdAt,
    required this.updatedAt,
    this.isDefault = true,
    this.isFavorite = false,
    this.isPublished = false
  });

  // To Json
  // Factory constructor to create a ChatBot instance from JSON
  factory ChatBot.fromJson(Map<dynamic, dynamic> json) {
    return ChatBot(
      id: json['id'] ?? '',
      assistantName: json['assistantName'] ?? '',
      description: json['description'] ?? '',
      openAiAssistantId: json['openAiAssistantId'] ?? '',
      instructions: json['instructions'] ?? '',
      openAiThreadIdPlay: json['openAiThreadIdPlay'] ?? '',
      createdAt: DateTime.parse(json['createdAt']), // Parse to DateTime
      updatedAt: DateTime.parse(json['updatedAt']), // Parse to DateTime
      // createdBy: json['createdBy'] ?? '',
      // updatedBy: json['updatedBy'] ?? '',
      isDefault: json['isDefault'] ?? true,
      isFavorite: json['isFavorite'] ?? false,
      isPublished: json['isPublished'] ?? false,
    );
  }

  // Convert ChatBot instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assistantName': assistantName,
      'description': description,
      'openAiAssistantId': openAiAssistantId,
      'instructions': instructions,
      'openAiThreadIdPlay': openAiThreadIdPlay,
      'createdAt': createdAt.toIso8601String(), // Convert to String
      'updatedAt': updatedAt.toIso8601String(), // Convert to String
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'isDefault': isDefault,
      'isFavorite': isFavorite,
      'isPublished': isPublished,
    };
  }

}