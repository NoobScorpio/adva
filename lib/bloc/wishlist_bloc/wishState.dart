import 'package:adva/data/model/wishlist.dart';
import 'package:equatable/equatable.dart';

abstract class WishListState extends Equatable {}

class WishListInitialState extends WishListState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WishListLoadingState extends WishListState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WishListLoadedState extends WishListState {
  final List<WishList> wishLists;

  WishListLoadedState({this.wishLists});

  @override
  // TODO: implement props
  List<Object> get props => [wishLists];
}

class WishListErrorState extends WishListState {
  final String message;

  WishListErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
