class ThreadMessage {
  final String role;
  final String content;
  final DateTime createdAt;

  ThreadMessage({
    required this.role,
    required this.content,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ThreadMessage.fromJson(Map<String, dynamic> json) {
    return ThreadMessage(
      role: json['role'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}