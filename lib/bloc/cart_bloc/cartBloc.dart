// import 'package:adva/bloc/cart_bloc/cartEvent.dart';
// import 'package:adva/bloc/cart_bloc/cartState.dart';
// import 'package:adva/bloc/product_bloc/productEvent.dart';
// import 'package:adva/bloc/product_bloc/productState.dart';
// import 'package:adva/data/model/cartItem.dart';
// import 'package:adva/data/model/product.dart';
// import 'package:adva/data/repository/cartRepo.dart';
// import 'package:adva/data/repository/productRepo.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class CartBloc extends Bloc<CartEvent, CartState> {
//   final CartRepository repository;
//
//   CartBloc({@required this.repository}) : super(null);
//
//   @override
//   // TODO: implement initialState
//   CartState get initialState => CartInitialState();
//
//   @override
//   Stream<CartState> mapEventToState(CartEvent event) async* {
//     if (event is AddItemCartEvent) {
//       yield CartLoadingState();
//       try {
//         bool added = repository.addItem(event.cartItem);
//         yield CartItemAddedState(added: added);
//       } catch (e) {
//         yield CartErrorState(message: e.toString());
//       }
//     }
//     if (event is RemoveItemCartEvent) {
//       yield CartLoadingState();
//       try {
//         bool removed = repository.removeItem(event.cartID);
//         yield CartItemRemoveState(removed: removed);
//       } catch (e) {
//         yield CartErrorState(message: e.toString());
//       }
//     }
//     if (event is GetCartItemsEvent) {
//       yield CartLoadingState();
//       try {
//         List<CartItem> cartItems = repository.getItems();
//         yield GetCartItemState(cartItems: cartItems);
//       } catch (e) {
//         yield CartErrorState(message: e.toString());
//       }
//     }
//   }
// }
