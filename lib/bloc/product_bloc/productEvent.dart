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
