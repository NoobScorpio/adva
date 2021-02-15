import 'package:adva/data/model/cart.dart';
import 'package:adva/data/model/cartItem.dart';

abstract class CartRepository {
  bool addItem(CartItem cartItem);
  List<CartItem> getItems();
  bool removeItem(int itemID);
}

class CartRepositoryImpl extends CartRepository {
  Cart cart = Cart();

  @override
  bool addItem(CartItem cartItem) {
    try {
      bool prev = false;
      if (cart.cartItem == null) {
        cart.cartItem = [];
      }
      for (int i = 0; i < cart.cartItem.length; i++) {
        if (cart.cartItem[i].id == cartItem.id) {
          cart.cartItem[i].qty += cartItem.qty;
          prev = true;
          break;
        }
      }
      if (prev) {
        return true;
      } else {
        cart.cartItem.add(cartItem);
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  List<CartItem> getItems() {
    return cart.cartItem ?? [];
  }

  @override
  bool removeItem(int itemID) {
    bool deleted = false;
    try {
      for (int i = 0; i < cart.cartItem.length; i++) {
        if (cart.cartItem[i].id == itemID) {
          cart.cartItem.removeAt(i);
          deleted = true;
        }
      }
      return deleted;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
