import 'package:adva/data/model/cartItem.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {}

class AddItemCartEvent extends CartEvent {
  final CartItem cartItem;

  AddItemCartEvent(this.cartItem);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RemoveItemCartEvent extends CartEvent {
  final int cartID;

  RemoveItemCartEvent(this.cartID);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class EmptyCartEvent extends CartEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GetCartItemsEvent extends CartEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
