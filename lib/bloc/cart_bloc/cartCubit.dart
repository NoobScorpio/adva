import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/repository/cartRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;

  CartCubit({this.cartRepository}) : super(CartInitialState([]));

  Future<bool> addItem(CartItem cartItem) async {
    try {
      List<CartItem> added = await cartRepository.addItem(cartItem);
      emit(CartItemAddedState(added: added));
      List<CartItem> cartItems = await cartRepository.getItems();
      emit(CartLoadedState(cartItems: cartItems));
      return added == null || added.length == 0 ? false : true;
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
      return false;
    }
  }

  Future<bool> removeItem(CartItem cartItem, bool remove) async {
    try {
      List<CartItem> removed =
          await cartRepository.removeItem(cartItem, remove);
      emit(CartItemRemoveState(removed: removed));
      List<CartItem> cartItems = await cartRepository.getItems();
      emit(CartLoadedState(cartItems: cartItems));
      return removed == null ? false : true;
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
      return false;
    }
  }

  Future<List<CartItem>> getItems() async {
    try {
      List<CartItem> cartItems = await cartRepository.getItems();
      emit(CartLoadedState(cartItems: cartItems));
      return cartItems;
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
      return [];
    }
  }
}
