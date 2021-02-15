import 'package:equatable/equatable.dart';

//////////////////////    EVENTS      /////////////////////////////

abstract class ProductEvent extends Equatable {}

class FetchProductEvent extends ProductEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FetchCategoryProductEvent extends ProductEvent {
  final String catName;

  FetchCategoryProductEvent(this.catName);
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
