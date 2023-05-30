import 'dart:convert';
import 'dart:core';
import 'package:bloccrud_muhammedessa/models/postmodel.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  String postUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<PostModel>> getPosts() async {
    http.Response response = await http.get(Uri.parse(postUrl));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<PostModel> getPostById(int id) async {
    http.Response response = await http.get(Uri.parse('$postUrl/$id'));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      PostModel postModel = PostModel.fromJson(result);
      return postModel;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<bool> createPost(PostModel postModel) async {
    var response = await http.post(Uri.parse(postUrl),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: json.encode(postModel.toJson()));
    print('status: ${response.statusCode}');
    return response.statusCode == 200;
  }

  Future<bool> updatePost(PostModel postModel) async {
    var response = await http.put(Uri.parse('$postUrl/${postModel.id}'),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: json.encode(postModel.toJson()));
    print('status: ${response.statusCode}');

    return response.statusCode == 200;
  }

  Future<bool> deletePost(int id) async {
    var response = await http.delete(
      Uri.parse('$postUrl/$id'),
    );
    print('status: ${response.statusCode}');
    return response.statusCode == 200;
  }
}
