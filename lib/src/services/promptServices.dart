import 'dart:convert';

import 'package:http/http.dart';

import '../constant/apiURL.dart';
import '../models/prompt.dart';

class PromptServices {

  Future<void> createNewPrivatePrompt({required PromptModel toBeCreatedPromt, required String accessToken}) async {
    print(toBeCreatedPromt.title);
    final body=jsonEncode({
      'category': toBeCreatedPromt.category??"other",
      'content': toBeCreatedPromt.content??"abc",
      'description': toBeCreatedPromt.description??"",
      'isPublic': toBeCreatedPromt.isPublic,
      'language': toBeCreatedPromt.language??"",
      'title': toBeCreatedPromt.title??"abc",
    });
    final response = await post(
      Uri.parse(APIURL.createPrompt),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;encoding=utf-8',
      },
      body: body,
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 201) {
      throw Exception(jsonDecode['details']);
    }
  }

  Future<List<PromptModel>> getPrompt({
    String? query,
    String? accessToken,
    int? offset,
    int? limit,
    String? category,
    bool? isFavorite,
    bool? isPublic,
    required Function(bool) onSucess
  }) async {
    String queryParams='?';
    if (query != null && query.trim()!='') queryParams+="query=$query";
    if (offset != null) queryParams+="&offset=$offset";
    if (limit != null) queryParams+="&limit=$limit";
    if (category != null) queryParams+="&category=$category";
    if (isFavorite != null) queryParams+="&isFavorite=$isFavorite";
    if (isPublic != null) queryParams+="&isPublic=$isPublic";
    final response = await get(
      Uri.parse(APIURL.getPrompt+queryParams),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(APIURL.getPrompt+queryParams);

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final items=jsonDecode['items'];
    List<PromptModel> result=[];
    items.forEach((item)=> result.add(PromptModel(id: item["_id"],
                                                  isPublic: item["isPublic"],
                                                  isFavorite: item["isFavorite"],
                                                  updatedAt: item["updatedAt"],
                                                  content: item["content"],
                                                  description: item["description"],
                                                  title: item["title"],
                                                  language: item["language"],
                                                  category: item["category"],
                                                  userId: item["userId"],
                                                  userName: item["userName"],
                                                  createdAt: item["createdAt"])));
    onSucess(jsonDecode['hasNext']);
    return result;

  }


  Future<void> updatePromt({required PromptModel updatePromt, required String accessToken}) async {
    final body=jsonEncode({
      'category': updatePromt.category??"other",
      'content': updatePromt.content??"abc",
      'description': updatePromt.description??"",
      'isPublic': updatePromt.isPublic,
      'language': updatePromt.language??"",
      'title': updatePromt.title??"abc",
    });
    final response = await patch(
      Uri.parse(APIURL.updatePrompt(updatePromt.id!)),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;encoding=utf-8',
      },
      body: body,
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['details']);
    }
  }

  Future<void> deletePrompt({required String id, required String accessToken}) async {
    final response = await delete(
      Uri.parse(APIURL.deletePrompt(id)),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['details']);
    }
  }

  Future<void> addPromptToFavorite({required String id, required String accessToken}) async {
    final response = await post(
      Uri.parse(APIURL.addPromptToFavorite(id)),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['details']);
    }
  }

  Future<void> removePromptFromFavorite({required String id, required String accessToken}) async {
    final response = await delete(
      Uri.parse(APIURL.removePromptToFavorite(id)),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['details']);
    }
  }

}