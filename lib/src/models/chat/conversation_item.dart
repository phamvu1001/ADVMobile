class ConversationItem {
  final String query;
  final String answer;
  final int createdAt;
  final List<String> files;

  ConversationItem({
    required this.query,
    required this.answer,
    required this.createdAt,
    this.files = const [],
  });
}