import 'package:adva/data/model/comment.dart';
import 'package:adva/data/model/customer.dart';
import 'package:adva/data/model/like.dart';

class PostModel {
  int id;
  int customerId;
  String description;
  String image;
  String createdAt;
  String updatedAt;
  int likesCount;
  int commentsCount;
  Customer customer;
  List<Comments> comments;
  List<Likes> likes;

  PostModel(
      {this.id,
      this.customerId,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.likesCount,
      this.commentsCount,
      this.customer,
      this.comments,
      this.likes});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = new List<Likes>();
      json['likes'].forEach((v) {
        likes.add(new Likes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostResultModel {
  List<PostModel> posts;

  PostResultModel({this.posts});

  PostResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      posts = List<PostModel>();
      json.forEach((v) {
        posts.add(new PostModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
