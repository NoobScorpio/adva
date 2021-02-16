import 'package:equatable/equatable.dart';

//////////////////////    EVENTS      /////////////////////////////

abstract class CategoryEvent extends Equatable {}

class FetchCategoryEvent extends CategoryEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FetchProductsByCategoryEvent extends CategoryEvent {
  final String catName;

  FetchProductsByCategoryEvent(this.catName);
  @override
  // TODO: implement props
  List<Object> get props => [catName];
}

class FetchProductsEvent extends CategoryEvent {
  final String cid;

  FetchProductsEvent(this.cid);
  @override
  // TODO: implement props
  List<Object> get props => [cid];
}
