import 'package:adva/data/model/comment.dart';
import 'package:adva/ui/utils/comment.dart';
import 'package:flutter/material.dart';

List<Widget> makeComments(List<Comments> comments) {
  List<Widget> widgets = [];
  for (Comments comment in comments) {
    widgets.add(Comment(
        image: comment.customer == null ? null : comment.customer.profileImage,
        body: comment.comment,
        name: comment.customer == null
            ? null
            : comment.customer.firstName + " " + comment.customer.lastName));
  }
  return widgets;
}
