import 'dart:convert';

import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/taxRate.dart';
import 'package:adva/data/repository/cartRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  SharedPreferences sp;
  TaxRate tax;
  CartCubit({this.cartRepository}) : super(CartInitialState([]));

  Future<bool> addItem(CartItem cartItem) async {
    try {
      dynamic sub = 0.0, total = 0.0, vat = 0.0, discount = 0.0;
      List<CartItem> added = await cartRepository.addItem(cartItem);
      sp = await SharedPreferences.getInstance();
      tax = TaxRate.fromJson(jsonDecode(sp.getString('taxRate')));

      if (added.length > 0) {
        for (CartItem cartItem in added) {
          sub += (cartItem.price ?? 0.0) * (cartItem.qty ?? 0);
          vat += cartItem.vat *
                  ((cartItem.price * (tax.taxValue / 100)) * cartItem.qty) ??
              0.0;
          discount +=
              (cartItem.discount ?? 0.0) / 100 * (cartItem.price ?? 0.0);
        }
        total = sub + vat;
      }
      emit(CartItemAddedState(
          added: added,
          total: total,
          subTotal: sub,
          vat: vat,
          discount: discount));
      emit(CartLoadedState(
          cartItems: added,
          total: total,
          subTotal: sub,
          vat: vat,
          discount: discount));
      return added == null || added.length == 0 ? false : true;
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
      return false;
    }
  }

  Future<bool> removeItem(CartItem cartItem, bool remove) async {
    try {
      dynamic sub = 0.0, total = 0.0, vat = 0.0, discount = 0.0;
      List<CartItem> removed =
          await cartRepository.removeItem(cartItem, remove);
      sp = await SharedPreferences.getInstance();
      tax = TaxRate.fromJson(jsonDecode(sp.getString('taxRate')));

      if (removed.length > 0) {
        for (CartItem cartItem in removed) {
          sub += (cartItem.price ?? 0.0) * (cartItem.qty ?? 0);
          vat += cartItem.vat *
                  ((cartItem.price * (tax.taxValue / 100)) * cartItem.qty) ??
              0.0;
          // discount +=
          //     (cartItem.discount ?? 0.0) / 100 * (cartItem.price ?? 0.0);
        }
        total = sub + vat;
      }
      emit(CartItemRemoveState(
          removed: removed,
          total: total,
          subTotal: sub,
          vat: vat,
          discount: discount));
      emit(CartLoadedState(
          cartItems: removed,
          total: total,
          subTotal: sub,
          vat: vat,
          discount: discount));
      return removed == null ? false : true;
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
      return false;
    }
  }

  Future<List<CartItem>> getItems() async {
    try {
      dynamic sub = 0.0, total = 0.0, vat = 0.0;
      List<CartItem> cartItems = await cartRepository.getItems();
      sp = await SharedPreferences.getInstance();
      tax = TaxRate.fromJson(jsonDecode(sp.getString('taxRate')));

      if (cartItems.length > 0) {
        for (CartItem cartItem in cartItems) {
          sub += (cartItem.price ?? 0.0) * (cartItem.qty ?? 0);
          vat += cartItem.vat *
                  ((cartItem.price * (tax.taxValue / 100)) * cartItem.qty) ??
              0.0;
          // discount +=
          //     (cartItem.discount ?? 0.0) / 100 * (cartItem.price ?? 0.0);
        }
        total = sub + vat;
      }
      emit(CartLoadedState(cartItems: cartItems, subTotal: sub, total: total));
      return cartItems;
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
      return [];
    }
  }

  Future<void> emptyCart() async {
    try {
      dynamic sub = 0.0, total = 0.0;
      await cartRepository.emptyCart();

      emit(CartLoadedState(cartItems: [], subTotal: sub, total: total));
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
    }
  }
}
