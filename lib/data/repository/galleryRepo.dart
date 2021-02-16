import 'dart:convert';

import 'package:adva/data/model/post.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class GalleryRepository {
  Future<List<Post>> getPosts({String filter});
}

class GalleryRepositoryImpl implements GalleryRepository {
  @override
  Future<List<Post>> getPosts({String filter}) async {
    var response = await http.get(baseURL + "/posts?filter=$filter");
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        List<Post> posts = PostResultModel.fromJson(data).posts;
        return posts;
      } catch (e) {
        // print(e);
        return [];
      }
    } else if (response.statusCode == 400) {
      throw UnimplementedError('This data does not exist.');
    } else if (response.statusCode == 500) {
      throw UnimplementedError('Internal server error.');
    } else {
      throw UnimplementedError('Something went wrong');
    }
  }
}
