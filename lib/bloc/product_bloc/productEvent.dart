import 'dart:io';

import 'package:equatable/equatable.dart';

//////////////////////    EVENTS      /////////////////////////////

abstract class ProductEvent extends Equatable {}

class FetchProductEvent extends ProductEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FetchProductByIDEvent extends ProductEvent {
  final int pid;

  FetchProductByIDEvent(this.pid);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PostProductQuestionEvent extends ProductEvent {
  final int pid, cid;
  final String question;

  PostProductQuestionEvent(this.pid, this.question, this.cid);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PostProductQuestionScreenEvent extends ProductEvent {
  final int pid, cid;
  final String question;

  PostProductQuestionScreenEvent(this.pid, this.question, this.cid);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PostProductReviewEvent extends ProductEvent {
  final int pid, cid, stars;
  final String message;
  final List<File> pictures;

  PostProductReviewEvent(
      this.pid, this.message, this.cid, this.pictures, this.stars);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PostProductReviewScreenEvent extends ProductEvent {
  final int pid, cid, stars;
  final String message;
  final List<File> pictures;

  PostProductReviewScreenEvent(
      this.pid, this.message, this.cid, this.pictures, this.stars);
  @override
  // TODO: implement props
  List<Object> get props => null;
}
