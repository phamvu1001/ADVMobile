import 'dart:core';

class PromptModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? category;
  String? content;
  String? description;
  bool? isPublic;
  String? language;
  String? title;
  String? userId;
  String? userName;
  bool? isFavorite;

  PromptModel({
    this.id,
    this.createdAt,
    this.isPublic,
    this.isFavorite,
    this.updatedAt,
    this.content,
    this.description,
    this.language,
    this.title,
    this.category,
    this.userId,
    this.userName
  });

  factory PromptModel.fromJSON(Map<String, dynamic> json) {
    return PromptModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      category: json['category'] as String?,
      content: json['content'] as String?,
      description: json['description'] as String?,
      isPublic: json['isPublic'] as bool?,
      language: json['language'] as String?,
      title: json['title'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      isFavorite: json['isFavorite'] as bool?,
    );
  }

  // toJSON: Chuyển đổi đối tượng PromptModel thành JSON
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'category': category,
      'content': content,
      'description': description,
      'isPublic': isPublic,
      'language': language,
      'title': title,
      'userId': userId,
      'userName': userName,
      'isFavorite': isFavorite,
    };
  }
}