class Assistant {
  String id = '';
  String name = '';
  String model = 'dify';

  Assistant({required this.id, required this.name});

  Map<String, String> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model
    };
  }
}