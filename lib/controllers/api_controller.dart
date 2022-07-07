import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_api/models/api_model.dart';
import 'package:http/http.dart' as http;

class PostController {
  ValueNotifier<List<Post>> posts = ValueNotifier<List<Post>>([]);
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

//BASICO PARA CHAMAR UMA API
  void callAPI() async {
    var client = http.Client();
    try {
      inLoader.value = true;
      var response =
          await client.get(Uri.parse('http://localhost:3000/praises'));
      var decodedResponse = jsonDecode(response.body) as List;
      posts.value = decodedResponse.map((e) => Post.fromJson(e)).toList();
    } finally {
      client.close();
      inLoader.value = false;
    }
  }
}
