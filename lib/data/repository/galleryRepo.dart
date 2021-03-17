import 'dart:convert';
import 'dart:io';

import 'package:adva/data/model/post.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class GalleryRepository {
  Future<List<PostModel>> getPosts({String filter});
  Future<List<PostModel>> postMedia({File image, String desc, int cid});
  Future<List<PostModel>> postLike({int pid, int cid});
  Future<bool> postComment({int pid, int cid, String comment});
}

class GalleryRepositoryImpl implements GalleryRepository {
  @override
  Future<List<PostModel>> getPosts({String filter}) async {
    var response = await http.get(Uri.parse(baseURL + "/posts?filter=$filter"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        List<PostModel> posts = PostResultModel.fromJson(data).posts;
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

  @override
  Future<List<PostModel>> postMedia({File image, String desc, int cid}) async {
    try {
      List<int> imageBytes = image.readAsBytesSync();
      String baseImage = base64Encode(imageBytes);
      String ext = image.path.split('/').last.split('.').last;
      print("#GALLERY $ext");
      var response = await http
          .post(Uri.parse(baseURL + "/media/basedecode/create/post"), body: {
        "customer_id": "$cid",
        "description": "$desc",
        "image": baseImage,
        "extenstion": ext
      });
      print("${response.body} ");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print("${response.statusMessage} ${response.data}");
        print("${response.body} ");
        var data = json.decode(response.body);
        List<PostModel> posts = PostResultModel.fromJson(data).posts;
        return posts;
      } else if (response.statusCode == 400) {
        // print("${response.statusMessage} ${response.data}");
        // print(response.statusMessage);
        print("${response.body} ");
        return null;
      } else if (response.statusCode == 500) {
        // print("${response.statusMessage} ${response.data}");
        print("${response.body} ");
        return null;
      } else {
        // print(response.statusMessage);
        print("${response.body} ");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<PostModel>> postLike({int pid, int cid}) async {
    var response = await http.post(Uri.parse(baseURL + "/customer/like/$pid"),
        body: {"customer_id": cid.toString()});
    print("GALLERY RESPONSE: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        List<PostModel> posts = PostResultModel.fromJson(data).posts;
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

  @override
  Future<bool> postComment({int pid, int cid, String comment}) async {
    var response = await http.post(Uri.parse(baseURL + "/media/comment/$pid"),
        body: {"customer_id": cid.toString(), "comment": comment});
    print("GALLERY RESPONSE: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else if (response.statusCode == 400) {
      return false;
    } else if (response.statusCode == 500) {
      return false;
    } else {
      return false;
    }
  }
}
