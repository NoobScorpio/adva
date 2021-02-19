import 'dart:convert';

import 'package:adva/data/model/myCart.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartRepository {
  Future<List<CartItem>> addItem(CartItem cartItem);
  Future<List<CartItem>> getItems();
  Future<List<CartItem>> removeItem(CartItem cartItem, bool remove);
}

class CartRepositoryImpl extends CartRepository {
  // Cart cart = Cart();
  SharedPreferences sharedPreferences;

  CartRepositoryImpl();
  @override
  Future<List<CartItem>> addItem(CartItem cartItem) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      MyCart cart = MyCart();
      var getCart = sharedPreferences.getString('cart');

      if (getCart == null) {
        cart.cartItem.add(cartItem);

        await sharedPreferences.setString('cart', json.encode(cart.toJson()));
      } else {
        cart = MyCart.fromJson(json.decode(getCart));
        // cartItem.id=cart.cartItem.length+1;
        for (int i = 0; i < cart.cartItem.length; i++) {
          if (cartItem == cart.cartItem[i]) {
            cart.cartItem[i].qty += cartItem.qty;
            await sharedPreferences.setString(
                'cart', json.encode(cart.toJson()));
            return cart.cartItem;
          }
        }
        cart.cartItem.add(cartItem);
        await sharedPreferences.setString('cart', json.encode(cart.toJson()));
      }

      return cart.cartItem;
      // }
    } catch (e) {
      print(e);
      return null;
    }
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  Future<List<CartItem>> getItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var getCart = sharedPreferences.getString('cart');

    if (getCart == null) {
      return [];
    } else {
      MyCart cart = MyCart();
      cart = MyCart.fromJson(json.decode(getCart));
      return cart.cartItem ?? [];
    }
  }

  @override
  Future<List<CartItem>> removeItem(CartItem cartItem, bool remove) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var getCart = sharedPreferences.getString('cart');
    MyCart cart = MyCart();
    cart = MyCart.fromJson(json.decode(getCart));
    if (remove) {
      for (int i = 0; i < cart.cartItem.length; i++) {
        if (cart.cartItem[i] == cartItem) {
          cart.cartItem.removeAt(i);
          await sharedPreferences.setString('cart', json.encode(cart.toJson()));
          return cart.cartItem;
        }
      }
      return null;
    } else {
      if (cart.cartItem.length == 0) {
        return [];
      } else {
        for (int i = 0; i < cart.cartItem.length; i++) {
          if (cart.cartItem[i] == cartItem) {
            if (cart.cartItem[i].qty >= 2) {
              cart.cartItem[i].qty--;
              // cart.cartItem.removeAt(i);
              await sharedPreferences.setString(
                  'cart', json.encode(cart.toJson()));
              return cart.cartItem;
            } else {
              // cart.cartItem[i].qty--;
              cart.cartItem.removeAt(i);
              await sharedPreferences.setString(
                  'cart', json.encode(cart.toJson()));
              return cart.cartItem;
            }
          }
        }
        return null;
      }
    }
  }
}
